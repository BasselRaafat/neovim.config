local M = {}

M.setup = function(servers)
	---@diagnostic disable-next-line: missing-fields
	require("mason").setup({
		registries = {
			"github:mason-org/mason-registry",
			"github:crashdummyy/mason-registry",
		},
	})
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua", -- Used to format Lua code
	})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
end

return M
