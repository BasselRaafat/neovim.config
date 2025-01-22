---@diagnostic disable: missing-fields
return {
	"smoka7/hop.nvim",
	version = "*",
	event = { "VeryLazy", "BufReadPre", "BufNewFile" },
	enable = false,
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function(_, opts)
		local hop = require("hop")
		hop.setup(opts)
		local directions = require("hop.hint").HintDirection
		vim.keymap.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		end, { remap = true })
		vim.keymap.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		end, { remap = true })
	end,
}
