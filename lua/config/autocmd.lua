vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		local clients = vim.lsp.get_clients({ name = "roslyn" })
-- 		if not clients or #clients == 0 then
-- 			return
-- 		end
-- 		print(#clients)
-- 		local ctx = clients[1]
-- 		local client = assert(vim.lsp.get_client_by_id(ctx.id))
-- 		local buffers = vim.lsp.get_buffers_by_client_id(ctx.id)
-- 		for _, buf in ipairs(buffers) do
-- 			local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
-- 			client:request("textDocument/diagnostic", params, nil, buf)
-- 		end
-- 	end,
-- })

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

local handles = {}
vim.api.nvim_create_autocmd("User", {
	pattern = "RoslynRestoreProgress",
	callback = function(ev)
		local token = ev.data.params[1]
		local handle = handles[token]
		if handle then
			handle:report({
				title = ev.data.params[2].state,
				message = ev.data.params[2].message,
			})
		else
			handles[token] = require("fidget.progress").handle.create({
				title = ev.data.params[2].state,
				message = ev.data.params[2].message,
				lsp_client = {
					name = "roslyn",
				},
			})
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "RoslynRestoreResult",
	callback = function(ev)
		local handle = handles[ev.data.token]
		handles[ev.data.token] = nil

		if handle then
			handle.message = ev.data.err and ev.data.err.message or "Restore completed"
			handle:finish()
		end
	end,
})
