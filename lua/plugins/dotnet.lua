local capabilities = require("config.lsp.capabilities")
---@module "lazy"
---@type LazySpec[]
return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		ft = { "cs", "cshtml", "xml", "csproj" },
		enabled = true,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				lsp = {
					enabled = true, -- Enable builtin roslyn lsp
					config = {
						capabilities = capabilities.capabilities,
					},
				},
				test_runner = {
					enable_buffer_test_execution = true,
					viewmode = "float",
				},
				auto_bootstrap_namespace = {
					enabled = true,
					type = "file-scoped",
				},
				debugger = {
					-- Path to custom coreclr DAP adapter
					-- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
					bin_path = vim.fn.stdpath("data") .. "\\mason\\packages\\netcoredbg\\netcoredbg",
					apply_value_converters = true,
					auto_register_dap = true,
					mappings = {
						open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
					},
				},
				terminal = function(path, action, args)
					local commands = {
						run = function()
							return string.format("dotnet run --project %s %s", path, args)
						end,
						test = function()
							return string.format("dotnet test %s %s", path, args)
						end,
						restore = function()
							return string.format("dotnet restore %s %s", path, args)
						end,
						build = function()
							return string.format("dotnet build %s %s", path, args)
						end,
					}

					local command = commands[action]() .. "\r"
					require("toggleterm").exec(command, nil, nil, nil, "float")
				end,
			})
		end,
	},
}
