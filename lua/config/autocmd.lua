-- local attach = require("plugins.lsp.attach")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
-- Load fold state
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.cmd([[silent! loadview]])
	end,
})

-- Save fold state
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
	callback = function()
		vim.cmd([[silent! mkview]])
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*",
	callback = function()
		local clients = vim.lsp.get_clients({ name = "roslyn" })
		if not clients or #clients == 0 then
			return
		end

		local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
		for _, buf in ipairs(buffers) do
			vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
		end
	end,
})
-- vim.api.nvim_create_autocmd({ "BufFilePre" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		local clients = vim.lsp.get_clients({ name = "roslyn" })
-- 		if not clients or #clients == 0 then
-- 			return
-- 		end
-- 		vim.cmd("Roslyn restart")
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
-- 	callback = attach.on_attach,
-- })
