local handler = require("plugins.util.nvim-ufo").handler
---@module "lazy"
---@type LazySpec
return {
	"kevinhwang91/nvim-ufo",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		local ufo = require("ufo")
		ufo.setup({
			fold_virt_text_handler = handler,
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				---@diagnostic disable-next-line: assign-type-mismatch
				json = { "array" },
				c = { "comment", "region" },
				cs = { "region" },
			},
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function(_, filetype, _)
				local ftMap = {
					vim = "indent",
					python = { "indent" },
					git = "",
				}
				return ftMap[filetype] or { "treesitter", "indent" }
			end,
		})
		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
		vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
		vim.keymap.set("n", "K", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				-- choose one of coc.nvim and nvim lsp
				vim.lsp.buf.hover()
			end
		end)
		-- vim.api.nvim_set_hl(0, "Folded", { fg = "#666666", bg = "NONE" })
	end,
}
