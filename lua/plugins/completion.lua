---@module "lazy"
---@type LazySpec[]
return {
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		enabled = true,
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "onsails/lspkind.nvim", opts = {
				preset = "codicons",
			} },
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
			cmdline = {
				keymap = { preset = "inherit" },
				completion = { menu = { auto_show = true } },
			},

			keymap = {
				preset = "default",
				["<C-a>"] = { "show", "hide" },
				["<C-space>"] = {},
			},
			appearance = {
				highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
				nerd_font_variant = "normal",
				use_nvim_cmp_as_default = false,
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				accept = { auto_brackets = { enabled = false } },
				keyword = { range = "full" },
				menu = {
					draw = {
						-- treesitter = {},
						align_to = "label",
						components = {
							kind_icon = {
								-- text = function(ctx)
								-- 	return require("lspkind").symbol_map[ctx.kind] or ""
								-- end,
								text = function(ctx)
									if ctx.source_name ~= "Path" then
										return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
									end

									local is_unknown_type = vim.tbl_contains(
										{ "link", "socket", "fifo", "char", "block", "unknown" },
										ctx.item.data.type
									)
									local mini_icon, _ = require("mini.icons").get(
										is_unknown_type and "os" or ctx.item.data.type,
										is_unknown_type and "" or ctx.label
									)

									return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
								end,

								highlight = function(ctx)
									if ctx.source_name ~= "Path" then
										return ctx.kind_hl
									end

									local is_unknown_type = vim.tbl_contains(
										{ "link", "socket", "fifo", "char", "block", "unknown" },
										ctx.item.data.type
									)
									local mini_icon, mini_hl = require("mini.icons").get(
										is_unknown_type and "os" or ctx.item.data.type,
										is_unknown_type and "" or ctx.label
									)
									return mini_icon ~= nil and mini_hl or ctx.kind_hl
								end,
							},
						},
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							-- { "label" },
							{ "kind" },
							-- { "source_name" },
							-- { "source_id" },
						},
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
				default = { "lsp", "path", "snippets", "buffer", "lazydev", "easy-dotnet" },
				--"omni" },
				providers = {
					["easy-dotnet"] = {
						name = "easy-dotnet",
						enabled = true,
						module = "easy-dotnet.completion.blink",
						-- score_offset = 10000,
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
			signature = {
				enabled = true,
				window = {
					max_width = 60,
					-- max_width = 100,
					max_height = 5,
					winblend = 1,
					scrollbar = true,
					show_documentation = true,
				},
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = (function()
			if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
				return
			end
			return "make install_jsregexp"
		end)(),
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")
			ls.setup({ enable_autosnippets = true })
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({
				paths = { "./lua/snippets" },
			})
			local s = ls.snippet
			local t = ls.text_node

			ls.add_snippets("cs", {
				s("set", t("{ get; set; }")),
				s("get", t("{ get; set; }")),
			})
		end,
	},
}
