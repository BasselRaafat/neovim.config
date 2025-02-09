-- return {
-- 	"cpea2506/one_monokai.nvim",
-- 	priority = 1000,
-- 	init = function()
-- 		vim.cmd.colorscheme("one_monokai")
-- 	end,
-- 	config = function()
-- 		require("one_monokai").setup({
-- 			transparent = true,
-- 			-- italics = true,
-- 		})
-- 	end,
-- }
-- return {
-- 	"navarasu/onedark.nvim",
--
-- 	priority = 1000,
-- 	init = function()
-- 		vim.cmd.colorscheme("onedark")
-- 	end,
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "warmer",
-- 			transparent = true,
-- 		})
-- 	end,
-- }
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	init = function()
-- 		vim.cmd.colorscheme("gruvbox")
-- 	end,
-- 	config = function()
-- 		require("gruvbox").setup({
--             dim_inactive=false,
-- 			contrast = "soft", -- can be "hard", "soft" or empty string
-- 			transparent_mode = true,
-- 		})
-- 	end,
-- }
return {
	"loctvl842/monokai-pro.nvim",
	config = function()
		require("monokai-pro").setup({
			devicons = true,
			transparent_background = true,

			background_clear = { "nvim-tree", "telescope" },
			plugins = {
				indent_blankline = {
					context_highlight = "pro",
					context_start_underline = true,
				},
			},
		})
		vim.cmd.colorscheme("monokai-pro")
	end,
}
