return {
	"SmiteshP/nvim-navic",
	event = { "FileReadPre" },
	dependencies = {
		"neovim/nvim-lspconfig",
		"LunarVim/breadcrumbs.nvim",
	},
	config = function()
		require("nvim-navic").setup({})
		require("breadcrumbs").setup()
	end,
}
