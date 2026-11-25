local M = {}

M.servers = {
	"lua_ls",
	"ts_ls",
	"roslyn",
	"bashls",
	"html",
	"jsonls",
	"vtsls",
	"tailwindcss",
	"eslint",
	"angularls",
	"cssls",
	"emmet_language_server",
}
M.ensure_installed = vim.tbl_deep_extend("force", M.servers, {
	"prettier",
	"stylua",
	"xmlformatter",
	-- "csharpier",
})

return M
