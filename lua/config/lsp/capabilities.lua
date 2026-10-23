local M = {}
M.capabilities = vim.lsp.protocol.make_client_capabilities()
-- M.capabilities = {}
-- M.capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }

-- capabilities.textDocument.semanticTokens.tokenTypes = {
-- -- my list of filtered tokens
-- }
--
-- M.capabilities.textDocument.completion.completionItem = {
-- 	documentationFormat = { "markdown", "plaintext" },
-- 	snippetSupport = true,
-- 	preselectSupport = true,
-- 	insertReplaceSupport = true,
-- 	labelDetailsSupport = true,
-- 	deprecatedSupport = true,
-- 	commitCharactersSupport = true,
-- 	tagSupport = { valueSet = { 1 } },
-- 	resolveSupport = {
-- 		properties = {
-- 			"documentation",
-- 			"detail",
-- 			"additionalTextEdits",
-- 		},
-- 	},
-- }
-- M.capabilities = vim.tbl_deep_extend("force", M.capabilities, { diagnosticProvider = { workspaceDiagnostics = true } })
M.capabilities = vim.tbl_deep_extend("force", M.capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
M.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

M.capabilities = vim.tbl_deep_extend("force", M.capabilities, {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
})

-- if M.capabilities.workspace then
-- 	M.capabilities.workspace.didChangeWatchedFiles = nil
-- end

return M
