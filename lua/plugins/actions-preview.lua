local previewer = require("telescope.previewers.previewer")
return {
	"aznhe21/actions-preview.nvim",
	config = function()
		vim.keymap.set(
			{ "v", "n" },
			"<leader>cp",
			require("actions-preview").code_actions,
			{ desc = "LSP: [C]ode Action [P]review", noremap = true, silent = true, nowait = true }
		)
		require("actions-preview").setup({
			-- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
			diff = { algorithm = "patience", ignore_whitespace = true },

			-- priority list of external command to highlight diff
			-- disabled by defalt, must be set by yourself
			highlight_command = {
				-- require("actions-preview.highlight").delta(),
				-- require("actions-preview.highlight").diff_so_fancy(),
				-- require("actions-preview.highlight").diff_highlight(),
			},

			-- priority list of preferred backend
			backend = { "telescope", "nui" },
			-- diff = {
			-- 	algorithm = "patience",
			-- 	ignore_whitespace = true,
			-- },
			-- options related to telescope.nvim
			telescope = vim.tbl_extend(
				"force",
				-- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
				{
					defaults = {
						layout_strategy = "horizontal", -- Choose a layout ('horizontal', 'vertical', 'center', 'flex')
						layout_config = {
							horizontal = {
								preview_width = 0.5, -- Adjust the width of the preview window (as a fraction of the total width)
							},
							vertical = {
								results_hight = 0.3, -- Adjust the height of the preview window (as a fraction of the total height)
							},
							width = 0.4, -- Overall width of Telescope (as a fraction of the screen width)
							height = 0.3, -- Overall height of Telescope (as a fraction of the screen height)
						},
					},
				},
				-- a table for customizing content
				{
					-- a function to make a table containing the values to be displayed.
					-- fun(action: Action): { title: string, client_name: string|nil }
					make_value = nil,

					-- a function to make a function to be used in `display` of a entry.
					-- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
					-- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
					make_make_display = nil,
				}
			),
		})
	end,
}
