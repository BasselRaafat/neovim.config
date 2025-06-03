-- local roslyn_handlers = {
-- 	["razor/provideDynamicFileInfo"] = function(_, _, _)
-- 		vim.notify(
-- 			"Razor is not supported.\nPlease use https://github.com/tris203/rzls.nvim",
-- 			vim.log.levels.WARN,
-- 			{ title = "roslyn_ls" }
-- 		)
-- 		return vim.NIL
-- 	end,
-- }

local capabilities = require("plugins.lsp.capabilities")
capabilities.textDocument.diagnostic.dynamicRegistration = true

return {
	name = "roslyn",
	filetypes = { "cs" },
	-- handlers = vim.tbl_extend("force", {}, vim.lsp.handlers, roslyn_handlers),
	capabilities = capabilities,
	timeout = 5000,
	cmd = {
		"roslyn",
		"--logLevel=Information",
		"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
		"--stdio",
	},
	settings = {
		-- ["csharp|background_analysis"] = {
		-- 	dotnet_analyzer_diagnostics_scope = "fullSolution",
		-- 	dotnet_compiler_diagnostics_scope = "fullSolution",
		-- },
		["csharp|inlay_hints"] = {
			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			csharp_enable_inlay_hints_for_lambda_parameter_types = true,
			csharp_enable_inlay_hints_for_types = true,
			dotnet_enable_inlay_hints_for_indexer_parameters = true,
			dotnet_enable_inlay_hints_for_literal_parameters = true,
			dotnet_enable_inlay_hints_for_object_creation_parameters = true,
			dotnet_enable_inlay_hints_for_other_parameters = true,
			dotnet_enable_inlay_hints_for_parameters = true,
			dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
			dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
		},
		["csharp|symbol_search"] = {
			dotnet_search_reference_assemblies = true,
		},
		["csharp|completion"] = {
			dotnet_show_name_completion_suggestions = true,
			dotnet_show_completion_items_from_unimported_namespaces = true,
			dotnet_provide_regex_completions = true,
		},
		["csharp|code_lens"] = {
			dotnet_enable_references_code_lens = true,
		},
	},
}
