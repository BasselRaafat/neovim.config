return {
	"kawre/neotab.nvim",
	event = "InsertEnter",
	opts = {
		-- configuration goes here
		tabkey = "<C-t>",
		act_as_tab = true,
	},
	config = function(_, opts)
		local neotab = require("neotab")
		neotab.setup(opts)
	end,
}
