-- local _, nvim_tree = pcall(require, "nvim-tree")
-- local ok, tree_config = pcall(require, "nvim-tree.config")
-- if not ok then
-- 	return {}
-- end
-- local tree_cb = tree_config.nvim_tree_callback
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	local function opts_without_buffer(desc)
		return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
	end
	-- copy default mappings here from defaults in next section
	--vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	--vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	---
	-- OR use all default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- remove a default
	--vim.keymap.del("n", "<C-]>", { buffer = bufnr })

	-- override a default
	--vim.keymap.set("n", "<C-e>", api.tree.reload, opts("Refresh"))

	-- add your mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open Node"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open Node"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Node"))
	vim.keymap.set("n", "<leader>tt", api.tree.toggle, opts_without_buffer("[T]oggle [T]ree"))
	vim.keymap.set("n", "<leader>tr", api.tree.reload, opts_without_buffer("[T]Refresh [R]Tree"))
	vim.keymap.set("n", "A", function()
		local node = api.tree.get_node_under_cursor()
		local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
		print(path)
		require("easy-dotnet").create_new_item(path)
	end, opts("Create file from dotnet template"))
end
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"GustavEikaas/easy-dotnet.nvim",
	},
	config = function()
		local HEIGHT_RATIO = 0.8 -- You can change this
		local WIDTH_RATIO = 0.4 -- You can change this too

		require("nvim-tree").setup({
			on_attach = my_on_attach,
			hijack_cursor = true,
			auto_reload_on_write = true,
			disable_netrw = true,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			prefer_startup_root = false,
			sync_root_with_cwd = false,
			reload_on_bufenter = false,
			respect_buf_cwd = false,
			select_prompts = false,
			sort = {
				sorter = "name",
				folders_first = true,
				files_first = false,
			},
			view = {
				centralize_selection = false,
				cursorline = true,
				debounce_delay = 15,
				side = "right",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				width = 30,
				float = {
					enable = false,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
						return {
							border = "rounded",
							relative = "editor",
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				-- width = function()
				-- 	return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				-- end,
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				full_name = false,
				root_folder_label = ":~:s?$?/..?",
				indent_width = 2,
				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
				hidden_display = "none",
				symlink_destination = true,
				highlight_git = "none",
				highlight_diagnostics = "none",
				highlight_opened_files = "none",
				highlight_modified = "none",
				highlight_hidden = "none",
				highlight_bookmarks = "none",
				highlight_clipboard = "name",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					web_devicons = {
						file = {
							enable = true,
							color = true,
						},
						folder = {
							enable = false,
							color = true,
						},
					},
					git_placement = "before",
					modified_placement = "after",
					hidden_placement = "after",
					diagnostics_placement = "signcolumn",
					bookmarks_placement = "signcolumn",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
						hidden = false,
						diagnostics = true,
						bookmarks = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						bookmark = "󰆤",
						modified = "●",
						hidden = "󰜌",
						folder = {
							arrow_closed = "",
							arrow_open = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = false,
				update_root = {
					enable = false,
					ignore_list = {},
				},
				exclude = false,
			},
			system_open = {
				cmd = "",
				args = {},
			},
			git = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				disable_for_dirs = {},
				timeout = 400,
				cygwin_support = false,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 500,
				severity = {
					min = vim.diagnostic.severity.ERROR,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = " ",
					info = " ",
					warning = " ",
					error = "",
				},
			},
			modified = {
				enable = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			filters = {
				enable = true,
				git_ignored = true,
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				no_bookmark = false,
				custom = {},
				exclude = {},
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {
					"/.ccls-cache",
					"/build",
					"/node_modules",
					"/target",
				},
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					eject = true,
					resize_window = true,
					relative_path = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			trash = {
				cmd = "gio trash",
			},
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			notify = {
				threshold = vim.log.levels.INFO,
				absolute_path = true,
			},
			help = {
				sort_by = "key",
			},
			ui = {
				confirm = {
					remove = true,
					trash = true,
					default_yes = false,
				},
			},
			experimental = {},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})
	end,
}
