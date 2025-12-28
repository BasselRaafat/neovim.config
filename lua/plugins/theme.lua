---@module "lazy"
---@type LazySpec[]
return {
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		lazy = false,
		-- opts = {
		-- 	devicons = true,
		-- 	transparent_background = false,
		-- 	filter = "spectrum",
		-- 	background_clear = { "nvim-tree", "telescope", "nvim-navic", "statuscol.nvim", "fidget.nvim" },
		-- },
		config = function()
			require("monokai-pro").setup({
				devicons = true,
				transparent_background = false,
				filter = "spectrum",
				background_clear = { "nvim-tree", "telescope", "nvim-navic", "statuscol.nvim", "fidget.nvim" },
			})
			vim.cmd([[colorscheme monokai-pro]])
		end,
	},
	{
		"cpea2506/one_monokai.nvim",
		lazy = true,
		opts = { transparent = true },
	},
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "warmer",
			transparent = true,
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			dim_inactive = false,
			contrast = "soft",
			transparent_mode = true,
		},
	},
}
