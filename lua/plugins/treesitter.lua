---@module "lazy"
---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	branch = "main",
	main = "nvim-treesitter",
	-- event = "BufReadPre",

	dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" } },
	-- init = function()
	-- 	vim.env.CC = "gcc"
	-- 	local ensureInstalled = {
	-- 		"bash",
	-- 		"c",
	-- 		"diff",
	-- 		"html",
	-- 		"lua",
	-- 		"luadoc",
	-- 		"markdown",
	-- 		"markdown_inline",
	-- 		"query",
	-- 		"vim",
	-- 		"vimdoc",
	-- 		"c_sharp",
	-- 		"javascript",
	-- 		"typescript",
	-- 		"json",
	-- 		"xml",
	-- 		"commonlisp",
	-- 		"scheme",
	-- 		"python",
	-- 	}
	-- 	local alreadyInstalled = require("nvim-treesitter.config").get_installed()
	-- 	local parsersToInstall = vim.iter(ensureInstalled)
	-- 		:filter(function(parser)
	-- 			return not vim.tbl_contains(alreadyInstalled, parser)
	-- 		end)
	-- 		:totable()
	-- 	require("nvim-treesitter").install(parsersToInstall)
	-- end,
	opts = {
		highlight = {
			enable = true, -- enables highlights and default injections
		},
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
			"c_sharp",
			"javascript",
			"typescript",
			"json",
			"xml",
			"commonlisp",
			"scheme",
			"python",
			"css",
			"angular",
		},
		auto_install = true,
		fold = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
		textobjects = {
			select = {
				enable = true,

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
					["as"] = { query = "@local.scope", query_group = "locals", desc = "language scope" },
				},
				include_surrounding_whitespace = false,
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = { query = "@function.outer", desc = "Next Method Start" },
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]v"] = { query = "call.outer", desc = "Next Functino Call" },

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
					["<leader>P"] = { query = "@parameter.inner", desc = "Swap Current Parameter With Previous" },
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		-- In the new nvim-treesitter main branch, highlighting is NOT auto-enabled.
		-- It must be started manually via FileType autocmd (lua works by default
		-- because Neovim ships built-in treesitter support for it).
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
		-- 	local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
		--
		-- 	-- Repeat movement with ; and ,
		-- 	-- ensure ; goes forward and , goes backward regardless of the last direction
		-- 	vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		-- 	vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
		--
		-- 	-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		-- 	vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, noremap = true })
		-- 	vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, noremap = true })
		-- 	vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, noremap = true })
		-- 	vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, noremap = true })
	end,
}
