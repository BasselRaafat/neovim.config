local servers = require("config.lsp.servers")
local ensure_installed = vim.tbl_deep_extend("force", servers, {
	"csharpier",
	"prettier",
	"stylua",
})
---@module "lazy"
---@type LazySpec[]
return {

	{
		"neovim/nvim-lspconfig",
		-- event = "LazyFile",
		lazy = true,
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:crashdummyy/mason-registry",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "mason-org/mason.nvim", opts = {} },
		},
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		opts = {
			ensure_installed = ensure_installed,
		},
	},

	{
		"SmiteshP/nvim-navic",
		event = { "BufReadPre" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"LunarVim/breadcrumbs.nvim",
		},

		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-navic").setup({})
			require("breadcrumbs").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		enabled = true,
		opts = {},
	},
	{
		"seblj/roslyn.nvim",
		enabled = true,
		opts = {
			filewatching = "auto",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
