local capabilities = require("config.lsp.capabilities").capabilities
local on_attach = require("config.lsp.on-attach").on_attach

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
})
-- vim.lsp.config("omnisharp", {
-- 	capabilities = capabilities,
-- 	enable_roslyn_analysers = true,
-- 	enable_import_completion = true,
-- 	organize_imports_on_format = true,
-- 	enable_decompilation_support = true,
-- 	filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets", "tproj", "slngen", "fproj" },
-- })
--
vim.lsp.enable({ "roslyn" })
--signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },virtual_text = { prefix = "" },
--[[
-- err = (err and err > 0) and ("%#St_lspError#" .. " " .. err .. " ") or ""
  warn = (warn and warn > 0) and ("%#St_lspWarning#" .. " " .. warn .. " ") or ""
  hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""
--]]
vim.diagnostic.config({
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
	virtual_text = {
		prefix = "●",
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
	signs = vim.g.have_nerd_font
			and {
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
			}
		or {},
})
vim.lsp.log.set_format_func(vim.inspect)
