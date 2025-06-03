-- local capabilities = require("plugins.lsp.capabilities")
-- local servers = require("plugins.lsp.servers").servers
-- local mason = require("plugins.lsp.mason")
return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	lazy = true,
	init = function()
		local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
		vim.opt.runtimepath:prepend(lspConfigPath)
	end,
	-- dependencies = {
	-- 	-- Automatically install LSPs and related tools to stdpath for Neovim
	-- 	{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
	-- 	-- "SmiteshP/nvim-navic",
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	-- Useful status updates for LSP.
	-- 	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	-- 	{ "j-hui/fidget.nvim", opts = {} },
	--
	-- 	-- Allows extra capabilities provided by nvim-cmp
	-- 	-- "hrsh7th/cmp-nvim-lsp",
	-- 	"saghen/blink.cmp",
	-- },
	-- config = function()
	-- 	mason.setup(servers)
	-- 	require("mason-lspconfig").setup({
	-- 		automatic_enable = true,
	-- 		automatic_installation = true,
	-- 		ensure_installed = {
	-- 			"html",
	-- 			"lua_ls", --[[/*"csharp_ls"*/ ]]
	-- 		},
	-- 		handlers = {
	-- 			function(server_name)
	-- 				local server = servers[server_name] or {}
	-- 				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
	-- 				require("lspconfig")[server_name].setup(server)
	-- 			end,
	-- 		},
	-- 	})
	-- end,
}
