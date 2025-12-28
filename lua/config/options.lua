vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.timeoutlen = 250

vim.opt.number = true

vim.opt.termguicolors = true

vim.opt.mouse = "a"

vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5
vim.opt.relativenumber = true

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.laststatus = 3
vim.opt.fillchars = { eob = " " }
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"

if vim.fn.has("win32") == 1 then
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.Formatting.Error = '';$PSStyle.Formatting.ErrorAccent = '';$PSStyle.Formatting.Warning = '';$PSStyle.OutputRendering = 'PlainText';"
	vim.opt.shellredir = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding utf8 %s; exit $LastExitCode"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end
vim.o.backupcopy = "yes"
