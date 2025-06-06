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

vim.api.nvim_create_user_command("CSFixUsings", function()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({ name = "roslyn" })
	if not clients or vim.tbl_isempty(clients) then
		vim.notify("Couldn't find client", vim.log.levels.ERROR, { title = "Roslyn" })
		return
	end

	local client = clients[1]
	local action = {
		kind = "quickfix",
		data = {
			CustomTags = { "RemoveUnnecessaryImports" },
			TextDocument = { uri = vim.uri_from_bufnr(bufnr) },
			CodeActionPath = { "Remove unnecessary usings" },
			Range = {
				["start"] = { line = 0, character = 0 },
				["end"] = { line = 0, character = 0 },
			},
			UniqueIdentifier = "Remove unnecessary usings",
		},
	}

	client.request("codeAction/resolve", action, function(err, resolved_action)
		if err then
			vim.notify("Fix using directives failed", vim.log.levels.ERROR, { title = "Roslyn" })
			return
		end
		vim.lsp.util.apply_workspace_edit(resolved_action.edit, client.offset_encoding)
	end)
end, { desc = "Remove unnecessary using directives" })

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
