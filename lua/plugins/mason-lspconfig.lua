local attach = require("plugins.lsp.attach")
local capabilities = require("plugins.lsp.capabilities")
local servers = require("plugins.lsp.servers").servers
local mason = require("plugins.lsp.mason")
return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by nvim-cmp
		-- "hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = attach.on_attach,
		})

		capabilities = capabilities.get_capabilities()

		mason.setup(servers)

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
						border = "rounded",
						-- max_width = 10,
						max_width = math.floor(vim.o.columns * 0.5),
						max_height = math.floor(vim.o.lines * 0.8),
						-- wrap_at = 1,
						warp = false,
					})

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
