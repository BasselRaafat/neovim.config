---@module "lazy"
---@type LazySpec[]
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		opts = {
			theme = "dragon",
			transparent = true,
		},
	},
	{
		"loctvl842/monokai-pro.nvim",
		lazy = true,
		-- priority = 1000,
		opts = {
			devicons = true,
			transparent_background = false,
			filter = "spectrum",
			background_clear = { "nvim-tree", "telescope", "nvim-navic", "statuscol.nvim", "fidget.nvim" },
		},
		-- lazy.nvim passes the `opts` table into the `config` function as the second argument
		-- config = function(_, opts)
		-- 	require("monokai-pro").setup(opts)
		-- 	vim.cmd([[colorscheme monokai-pro]])
		-- end,
	},
	{
		"cpea2506/one_monokai.nvim",
		lazy = true,
		opts = { transparent = true },
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "warmer",
			transparent = false,
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			require("onedark").load()
			-- vim.cmd([[colorscheme onedark]])
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		opts = {
			dim_inactive = false,
			contrast = "soft",
			transparent_mode = true,
		},
	},
}
