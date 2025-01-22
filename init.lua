require("mapping")
require("options")
require("lazyy")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	float = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
})
