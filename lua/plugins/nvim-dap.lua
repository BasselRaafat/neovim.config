return {
	"mfussenegger/nvim-dap",
	config = function()
		dap = require("dap")
		dap.adapters.coreclr = {
			type = "executable",
			command = "C:/Users/20103/AppData/Local/nvim-data/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll ", vim.fn.getcwd() .. "\\bin\\Debug\\", "file")
				end,
			},
		}
	end,
}
