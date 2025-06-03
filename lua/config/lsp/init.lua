local servers = require("config.lsp.servers").servers
local capabilities = require("config.lsp.capabilities").capabilities
local on_attach = require("config.lsp.on-attach").on_attach

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable(servers)

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
vim.lsp.log.set_format_func(vim.inspect)
