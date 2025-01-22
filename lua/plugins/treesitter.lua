return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<leader>vi",
				node_incremental = "<CR>",
				scope_incremental = "<Leader><CR>",
				node_decremental = "<BS>",
			},
		},
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["am"] = { query = "@function.outer", desc = "Method" },
					["im"] = { query = "@function.inner", desc = "Method" },
					["nm"] = { query = "@function.name", desc = "Method Name" },
					["ac"] = { query = "@class.outer", desc = "Class" },
					["ic"] = { query = "@class.inner", desc = "Class" },
					["nc"] = { query = "@class.name", desc = "Class Name" },
					["aa"] = { query = "@parameter.outer", desc = "Parameter" },
					["ia"] = { query = "@parameter.inner", desc = "Parameter" },
					["av"] = { query = "@call.outer", desc = "Invokation" },
					["iv"] = { query = "@call.inner", desc = "Invokation" },
					-- You can optionally set descriptions to the mappings (used in the desc parameter of
					-- nvim_buf_set_keymap) which plugins like which-key display
					-- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					-- You can also use captures from other query groups like `locals.scm`
					["as"] = { query = "@local.scope", query_group = "locals", desc = "language scope" },
				},
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				-- selection_modes = {
				-- 	["@parameter.outer"] = "v", -- charwise
				-- 	["@function.outer"] = "v", -- linewise
				-- 	["@class.outer"] = "v", -- blockwise
				-- },
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true or false
				include_surrounding_whitespace = false,
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = { query = "@function.outer", desc = "Next Method Start" },
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]v"] = { query = "call.outer", desc = "Next Functino Call" },
					-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
					-- ["]o"] = "@loop.*",
					-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
					--
					-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
					-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
					["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope Start" },
					["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold Start" },
					["]a"] = { query = "@parameter.inner", desc = "Next Paramter Start" },
				},
				goto_next_end = {
					["]M"] = { query = "@function.outer", desc = "Next Function End" },
					["]C"] = { query = "@class.outer", desc = "Next Class End" },
					["]A"] = { query = "@parameter.inner", desc = "Previous Paramter End" },
					["]V"] = { query = "call.outer", desc = "Previous Function Call End" },
					["]S"] = { query = "@local.scope", query_group = "locals", desc = "Next scope End" },
					["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold End" },
				},
				goto_previous_start = {
					["[m"] = { query = "@function.outer", desc = "Previous Method Start" },
					["[c"] = { query = "@class.outer", desc = "Previous Class Start" },
					["[a"] = { query = "@parameter.inner", desc = "Previous Paramter Start" },
					["[v"] = { query = "call.outer", desc = "Previous Function Call Start" },
					["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope Start" },
					["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold Start" },
				},
				goto_previous_end = {
					["[M"] = { query = "@function.outer", desc = "Previous Method End" },
					["[C"] = { query = "@class.outer", desc = "Previous Calss End" },
					["[A"] = { query = "@parameter.inner", desc = "Previous Paramter End" },
					["[V"] = { query = "call.outer", desc = "Previous Function Call End" },
					["[S"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope End" },
					["[Z"] = { query = "@fold", query_group = "folds", desc = "Previous fold End" },
				},
				-- Below will go to either the start or the end, whichever is closer.
				-- Use if you want more granular movements
				-- Make it even more gradual by adding multiple queries and regex.
				goto_next = {
					["]i"] = { query = "@conditional.outer", desc = "Next Condition" },
				},
				goto_previous = {
					["[i"] = { "@conditional.outer", desc = "Previous Condition" },
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>p"] = { query = "@parameter.inner", desc = "Swap Current Parameter With Next" },
				},
				swap_previous = {
					["<leader>p"] = { query = "@parameter.inner", desc = "Swap Current Parameter With Previous" },
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- Repeat movement with ; and ,
		-- ensure ; goes forward and , goes backward regardless of the last direction
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		-- vim way: ; goes to the direction you were moving.
		-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.peat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, noremap = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, noremap = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, noremap = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, noremap = true })
	end,
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
