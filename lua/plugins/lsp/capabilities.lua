local M = {}

M.get_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
end
return M
