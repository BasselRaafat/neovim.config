--
-- Set <space> as the leader key
-- See `:help mapleader`
--NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- vim.keymap.set({ "n", "v" }, "h", "<Left>")
-- vim.keymap.set({ "n", "v" }, "j", "<Left>")
-- vim.keymap.set({ "n", "v" }, "k", "<down>")
-- vim.keymap.set({ "n", "v" }, "l", "<Up>")
-- vim.keymap.set({ "n", "v" }, ";", "<Right>")
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("n", "oo", "o<Esc>")
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo 'Use h to move!!'<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo 'Use l to move!!'<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo 'Use k to move!!'<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo 'Use j to move!!'<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-w>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-w>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-w>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-w>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.keymap.set("n", "<leader>td", vim.diagnostic.open_float, { desc = "[T]Open [D]iagnostic float" })

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

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.6)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			local command = { "edit", "term://pwsh" }
			vim.cmd(vim.fn.join(command, " "))
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
	vim.cmd("normal i")
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tf", "<cmd>Floaterminal<CR>", { desc = "Float Terminal" })
