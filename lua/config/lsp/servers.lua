local M = {}

M.servers = {
	"lua_ls",
	"bashls",
	"html",
	"roslyn",
}
M.ensure_installed = vim.tbl_deep_extend("force", M.servers, {
	"csharpier",
	"prettier",
	"stylua",
})

return M
