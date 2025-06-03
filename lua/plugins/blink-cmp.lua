return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = {
		"onsails/lspkind.nvim",
		"nvim-tree/nvim-web-devicons",
		"echasnovski/mini.nvim",
		"rafamadriz/friendly-snippets",
		"GustavEikaas/easy-dotnet.nvim",
	},
	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	opts_extend = { "sources.default" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config

	opts = {
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
			nerd_font_variant = "normal",
			use_nvim_cmp_as_default = true,
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			keyword = { range = "full" },
			menu = {
				enabled = true,
				min_width = 15,
				max_height = 10,
				draw = {

					align_to = "label",
					columns = {
						{ "kind_icon" },
						{ "label", "kind", gap = 1 },
					},

					components = {
						label = {
							width = { max = 15 },
						},
					},
					gap = 0,
				},
				auto_show = true,
			},
			ghost_text = { enabled = true },

			documentation = {
				auto_show = true,
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer", "easy-dotnet" },
			providers = {
				["easy-dotnet"] = {
					name = "easy-dotnet",
					enabled = true,
					module = "easy-dotnet.completion.blink",
					score_offset = 10000,
					async = true,
				},
				["lazydev"] = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
			transform_items = function(_, items)
				return items
			end,
		},
		snippets = { preset = "luasnip" },
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
		signature = {
			enabled = true,
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				scrollbar = false,
				show_documentation = true,
			},
		},
	},
}
