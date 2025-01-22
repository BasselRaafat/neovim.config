return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")
		npairs.setup()
		local Rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")
		npairs.add_rule(Rule("<", ">"):with_pair(
			-- regex will make it so that it will auto-pair on
			-- `a<` but not `a <`
			-- The `:?:?` part makes it also
			-- work on Rust generics like `some_func::<T>()`
			cond.before_regex("%a+:?:?$", 3)
		):with_move(function(opts)
			return opts.char == ">"
		end))
		npairs.get_rule("{"):replace_map_cr(function()
			local res = "<c-g>u<CR><CMD>normal! ====<CR><up><end><CR>"
			local line = vim.fn.winline()
			local height = vim.api.nvim_win_get_height(0)
			-- Check if current line is within [1/3, 2/3] of the screen height.
			-- If not, center the current line.
			if line < height / 3 or height * 2 / 3 < line then
				-- Here, 'x' is a placeholder to make sure the indentation doesn't break.
				res = res .. "x<ESC>zzs"
			end
			return res
		end)
	end,
}
