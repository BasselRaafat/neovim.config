local capabilities = require("config.lsp.capabilities")
local on_attach = require("config.lsp.on-attach").on_attach

vim.lsp.config("*", {
	capabilities = capabilities.capabilities,
	on_attach = on_attach,
})

-- vim.lsp.config("easy_dotnet", {
-- 	capabilities = capabilities.capabilities,
-- 	on_attach = on_attach,
-- })
-- vim.lsp.config("html", {
-- 	filetypes = { "html", "htmlangular" },
-- })

vim.diagnostic.config({
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
	virtual_text = {
		prefix = function(_, i, _)
			if i == 1 then
				return "●"
			end
			return ""
		end,
		spacing = 2,
		severity = { min = vim.diagnostic.severity.WARN },
		source = "if_many",
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
	underline = true,
	update_in_insert = false,
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰛩",
			-- [vim.diagnostic.severity.HINT] = "󰌶",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	} or {},
})
vim.lsp.log.set_format_func(vim.inspect)
