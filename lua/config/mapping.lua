vim.g.have_nerd_font = true

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("n", "oo", "o<Esc>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-w>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-w>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-w>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-w>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set({ "n", "t" }, "<leader>tf", "<cmd>Floaterminal<CR>", { desc = "Float Terminal" })

vim.keymap.set("v", "<M-j>", ":m'>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m'<-2<CR>gv=gv")

vim.keymap.set("i", "<C-d>", function()
	vim.cmd.stopinsert()
	vim.lsp.buf.signature_help()
	vim.defer_fn(function()
		vim.cmd.wincmd("w")
	end, 100)
	vim.keymap.set("n", "q", ":close<CR>", { buffer = true })
end)
