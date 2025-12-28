---@module "lazy"
---@type LazySpec[]
return {
	{
		"nvchad/base46",
		enabled = false,
		dependencies = "nvim-lua/plenary.nvim",
		-- priority = 10000,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvchad/ui",
		dependencies = "nvchad/base46",
		enabled = false,
		lazy = false,
		init = function()
			vim.cmd.colorscheme("nvchad")
		end,
		config = function()
			require("nvchad")
		end,
	},
	{
		"nvzone/volt",
		enabled = false,
		lazy = false,
	},
	{
		"nvzone/menu",
		enabled = false,
		lazy = false,
		dependencies = "nvzone/volt",
	},
	{
		"nvzone/minty",
		enabled = false,
		cmd = { "Huefy", "Shades" },
	},
}
