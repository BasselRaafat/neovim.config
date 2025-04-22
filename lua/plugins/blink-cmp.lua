return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets", "GustavEikaas/easy-dotnet.nvim" },
	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config

	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		cmdline = {
			keymap = {
				-- recommended, as the default keymap will only show and select the next item
				["<Tab>"] = { "show", "accept" },
			},
			completion = {
				menu = {
					auto_show = function(_)
						return vim.fn.getcmdtype() == ":"
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
			},
		},
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },

		appearance = {
			highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = false,
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				-- Controls whether the documentation window will automatically show when selecting a completion item
				auto_show = true,

				-- Delay before showing the documentation window
				auto_show_delay_ms = 500,
				-- Delay before updating the documentation window when selecting a new item,
				-- while an existing item is still visible
				update_delay_ms = 50,
				-- Whether to use treesitter highlighting, disable if you run into performance issues
				treesitter_highlighting = true,
				-- Draws the item in the documentation window, by default using an internal treesitter based implementation
				draw = function(opts)
					opts.default_implementation()
				end,
				window = {
					min_width = 10,
					max_width = 80,
					max_height = 20,
					border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					-- Note that the gutter will be disabled when border ~= 'none'
					scrollbar = true,
					-- Which directions to show the documentation window,
					-- for each of the possible menu window directions,
					-- falling back to the next direction when there's not enough space
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},
			keyword = { range = "full" },
			menu = {

				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
				auto_show = true,
				-- draw = {
				-- 	columns = {
				-- 		{ "label", "label_description", gap = 1 },
				-- 		{ "kind_icon", "kind" },
				-- 	},
				-- },
			},
			ghost_text = { enabled = true, show_with_selection = true },
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "easy-dotnet" },
			providers = {
				["easy-dotnet"] = {
					name = "easy-dotnet",
					enabled = true,
					module = "easy-dotnet.completion.blink",
					score_offset = 10000,
					async = true,
				},
			},
			transform_items = function(_, items)
				return items
			end,
		},

		snippets = { preset = "luasnip" },
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = { "sources.default" },
	signature = {
		enabled = true,
		trigger = {
			-- Show the signature help automatically
			enabled = true,
			-- Show the signature help window after typing any of alphanumerics, `-` or `_`
			show_on_keyword = false,
			blocked_trigger_characters = {},
			blocked_retrigger_characters = {},
			-- Show the signature help window after typing a trigger character
			show_on_trigger_character = true,
			-- Show the signature help window when entering insert mode
			show_on_insert = false,
			-- Show the signature help window when the cursor comes after a trigger character when entering insert mode
			show_on_insert_on_trigger_character = true,
		},
		window = {
			min_width = 1,
			max_width = 100,
			max_height = 10,
			border = "rounded", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
			winblend = 0,
			winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
			scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
			-- Which directions to show the window,
			-- falling back to the next direction when there's not enough space,
			-- or another window is in the way
			direction_priority = { "n", "s" },
			-- Disable if you run into performance issues
			treesitter_highlighting = true,
			show_documentation = true,
		},
	},
}
