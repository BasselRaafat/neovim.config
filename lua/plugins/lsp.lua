local servers = require("config.lsp.servers").servers
local ensure_installed = require("config.lsp.servers").ensure_installed

---@module "lazy"
---@type LazySpec[]
return {

	{
		"neovim/nvim-lspconfig",
		-- event = "LazyFile",
		lazy = true,
		init = function()
			local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
			vim.opt.runtimepath:prepend(lspConfigPath)
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:crashdummyy/mason-registry",
			},
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "mason-org/mason.nvim", opts = {} },
		},
		opts = {},
		-- config = function(_, opts)
		-- 	require("mason-lspconfig").setup(opts)
		--
		-- 	require("mason-lspconfig").setup_handlers({
		-- 		-- The default handler runs for all installed servers
		-- 		function(server_name)
		-- 			require("lspconfig")[server_name].setup({})
		-- 		end,
		-- 		-- Custom handler specifically to load your orphaned lua_ls.lua config
		-- 		["lua_ls"] = function()
		-- 			-- dofile allows us to load the file directly from your root /lsp directory!
		-- 			local custom_config = dofile(vim.fn.stdpath("config") .. "/lsp/lua_ls.lua")
		-- 			require("lspconfig").lua_ls.setup(custom_config)
		-- 		end,
		-- 	})
		-- end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		opts = {
			ensure_installed = ensure_installed,
			auto_update = true,
		},
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},

	{
		"SmiteshP/nvim-navic",
		event = { "BufReadPre" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"LunarVim/breadcrumbs.nvim",
		},

		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-navic").setup({})
			require("breadcrumbs").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		enabled = true,
		opts = {},
	},
	{
		"seblj/roslyn.nvim",
		enabled = false,
		opts = {
			silent = false,
			filewatching = "auto",
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"nvim-dap-ui",
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local path = vim.fn.stdpath("data") .. "\\mason\\packages\\netcoredbg\\netcoredbg"
			vim.keymap.set("n", "q", function()
				dap.terminate()
				dap.clear_breakpoints()
			end, { desc = "Terminate and clear breakpoints" })

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt)" })
			vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
			vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
			vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
			vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })

			-- dap.adapters.netcoredbg = {
			-- 	type = "executable",
			-- 	command = path,
			-- 	args = { "--interpreter=vscode" },
			-- }
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{

		"khoido2003/roslyn-filewatch.nvim",
		enabled = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"seblj/roslyn.nvim",
		},
		config = function()
			require("roslyn_filewatch").setup()
		end,
	},
	{
		"esmuellert/nvim-eslint",
		enabled = true,
		config = function()
			require("nvim-eslint").setup({})
		end,
	},
}
