local M = {}

M.servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
	--
	-- Some languages (like typescript) have entire language plugins that can be useful:
	--    https://github.com/pmizio/typescript-tools.nvim
	--
	-- But for many setups, the LSP (`ts_ls`) will work just fine
	-- ts_ls = {},
	--

	-- omnisharp = {
	-- 	RoslynExtensionsOptions = {
	-- 		enableDecompilationSupport = true,
	-- 		EnableImportCompletion = true,
	-- 	},
	-- 	handlers = {
	-- 		["textDocument/definition"] = function()
	-- 			return require("omnisharp_extended").definition_handler()
	-- 		end,
	-- 		["textDocument/typeDefinition"] = function()
	-- 			return require("omnisharp_extended").type_definition_handler()
	-- 		end,
	-- 		["textDocument/references"] = function()
	-- 			return require("omnisharp_extended").references_handler()
	-- 		end,
	-- 		["textDocument/implementation"] = function()
	-- 			return require("omnisharp_extended").implementation_handler()
	-- 		end,
	-- 	},
	-- },
	lua_ls = {
		-- cmd = {...},
		-- filetypes = { ...},
		-- capabilities = {},
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}
return M
