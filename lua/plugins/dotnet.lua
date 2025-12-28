---@module "lazy"
---@type LazySpec[]
return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		ft = { "cs", "cshtml", "xml", "csproj" },
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				lsp = {
					enabled = false, -- Enable builtin roslyn lsp
				},
				test_runner = {
					enable_buffer_test_execution = true,
					viewmode = "float",
				},
				auto_bootstrap_namespace = true,
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
