return {
	"seblj/roslyn.nvim",
	ft = "cs",
	config = function()
		require("roslyn").setup({
			filewatching = "auto",
			args = {
				"--logLevel=Information",
				"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
				"--stdio",
			},
			---@diagnostic disable-next-line: missing-fields
			config = {
				on_attach = require("plugins.lsp.rosly-on-attach").on_attach,
				capabilities = require("plugins.lsp.capabilities").get_capabilities(),
				handlers = {
					function()
						vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
							border = "rounded",
							-- max_width = 10,
							max_width = math.floor(vim.o.columns * 0.5),
							max_height = math.floor(vim.o.lines * 0.8),
							-- wrap_at = 1,
							wrap = false,
						})
					end,
				},
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
					-- ["csharp|background_analysis"] = {
					-- 	dotnet_analyzer_diagnostics_scope = "fullSolution",
					-- 	dotnet_compiler_diagnostics_scope = "fullSolution",
					-- },
				},
			},
		})
	end,
}
