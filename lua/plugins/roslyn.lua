return {
	"seblj/roslyn.nvim",
	-- event = "VeryLazy",
	ft = "cs",
	dependencies = {
		{
			"tris203/rzls.nvim",
			ft = "cshtml",
			-- dev = true,
			config = function()
				require("rzls").setup({
					on_attach = require("plugins.lsp.rosly-on-attach").on_attach,
					capabilities = require("plugins.lsp.capabilities").get_capabilities(),
				})
			end,
		},
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		require("roslyn").setup({
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
				"--razorSourceGenerator=" .. vim.fs.joinpath(
					vim.fn.stdpath("data") --[[@as string]],
					"mason",
					"packages",
					"roslyn",
					"libexec",
					"Microsoft.CodeAnalysis.Razor.Compiler.dll"
				),
				"--razorDesignTimePath=" .. vim.fs.joinpath(
					vim.fn.stdpath("data") --[[@as string]],
					"mason",
					"packages",
					"rzls",
					"libexec",
					"Targets",
					"Microsoft.NET.Sdk.Razor.DesignTime.targets"
				),
			},
			---@diagnostic disable-next-line: missing-fields
			config = {
				on_attach = require("plugins.lsp.rosly-on-attach").on_attach,
				capabilities = require("plugins.lsp.capabilities").get_capabilities(),
				handlers = require("rzls.roslyn_handlers"),
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,

						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
					["csharp|diagnostics"] = {
						dotnet_diagnostic = {
							["IDE0290"] = {
								severity = "none", -- Use "none" to disable, or other levels like "error", "warning", etc.
							},
						},
					},
				},
			},
		})
		vim.api.nvim_create_autocmd({ "InsertLeave" }, {
			pattern = "*",
			callback = function()
				local clients = vim.lsp.get_clients({ name = "roslyn" })
				if not clients or #clients == 0 then
					return
				end

				local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
				for _, buf in ipairs(buffers) do
					vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
				end
			end,
		})
		vim.api.nvim_create_user_command("CSFixUsings", function()
			local bufnr = vim.api.nvim_get_current_buf()

			local clients = vim.lsp.get_clients({ name = "roslyn" })
			if not clients or vim.tbl_isempty(clients) then
				vim.notify("Couldn't find client", vim.log.levels.ERROR, { title = "Roslyn" })
				return
			end

			local client = clients[1]
			local action = {
				kind = "quickfix",
				data = {
					CustomTags = { "RemoveUnnecessaryImports" },
					TextDocument = { uri = vim.uri_from_bufnr(bufnr) },
					CodeActionPath = { "Remove unnecessary usings" },
					Range = {
						["start"] = { line = 0, character = 0 },
						["end"] = { line = 0, character = 0 },
					},
					UniqueIdentifier = "Remove unnecessary usings",
				},
			}

			client.request("codeAction/resolve", action, function(err, resolved_action)
				if err then
					vim.notify("Fix using directives failed", vim.log.levels.ERROR, { title = "Roslyn" })
					return
				end
				vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
			end)
		end, { desc = "Remove unnecessary using directives" })
	end,
}
