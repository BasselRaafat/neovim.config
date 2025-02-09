--Here  a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
return {
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		-- yadm = { enable = false },
		signcolumn = true,
	},
}
