local on_attach = require("plugins.util.nvim-tree").on_attach

---@module "lazy"
---@type LazySpec
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	priority = 2000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"GustavEikaas/easy-dotnet.nvim",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = on_attach,
			hijack_cursor = true,
			view = {
				side = "right",
				cursorline = true,
			},
			renderer = {
				root_folder_label = ":~:s?$?/..?",
				indent_markers = {
					enable = true,
					inline_arrows = true,
				},
				-- icons = {
				-- 	show = {
				-- 		file = true,
				-- 		folder = true,
				-- 		folder_arrow = true,
				-- 		git = true,
				-- 	},
				-- 	web_devicons = {
				-- 		folder = {
				-- 			enable = true,
				-- 		},
				-- 	},
				-- },
			},
			git = {
				timeout = 1550,
			},
			diagnostics = {
				debounce_delay = 1000,
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
				icons = {
					error = "",
				},
			},
			live_filter = {
				prefix = "[FILTER]: ",
			},
			notify = {
				absolute_path = true,
			},
		})
	end,
}
