local M = {}

M.on_attach = function(client, buf)
	local navic = require("nvim-navic")
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
	end
	local builtin = require("telescope.builtin")

	map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
	map("gr", builtin.lsp_references, "[G]oto [R]eferences")
	map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
	map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
	map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
	map("<leader>cl", vim.lsp.codelens.refresh, "[C]ode [L]ens", { "n", "x" })
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	map("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	map("<leader>sh", vim.lsp.buf.signature_help, "Signature Documentation")

	map("<leader>mt", function()
		vim.lsp.semantic_tokens.start(buf, client.id)
	end, "Semantic Tokens", { "n", "x" })
	map("<leader>ms", function()
		vim.lsp.semantic_tokens.stop(buf, client.id)
	end, "Semantic Tokens", { "n", "x" })

	--toggle inlay hints
	if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		map("<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }))
		end, "[T]oggle Inlay [H]ints")
	end

	--highlight symple under cursor
	if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
			callback = function(event)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
			end,
		})
	end

	if client and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, buf)
	end
end
return M
