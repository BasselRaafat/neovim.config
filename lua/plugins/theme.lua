-- return { -- You can easily change to a different colorscheme.
-- 	-- Change the name of the colorscheme plugin below, and then
-- 	-- change the command in the config to whatever the name of that colorscheme is.
-- 	--	 If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
-- 	"cpea2506/one_monokai.nvim",
-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
-- 	init = function()
-- 		-- Load the colorscheme here.
-- 		--Like many other themes, this one has different styles, and you could load
-- 		--any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
-- 		vim.cmd.colorscheme("one_monokai")
--
-- 		--You can configure highlights by doing something like:
-- 		vim.cmd.hi("Comment gui=none")
-- 	end,
-- 	config = function()
-- 		require("one_monokai").setup({
-- 			transparent = true,
-- 			-- colors = {},
-- 			-- themes = function(colors)
-- 			-- 	return {}
-- 			-- end,
-- 			-- italics = true,
-- 		})
-- 	end,
-- }
-- return {
-- 	"navarasu/onedark.nvim",
--
-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
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
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("gruvbox")
	end,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		})
	end,
	opts = ...,
}
