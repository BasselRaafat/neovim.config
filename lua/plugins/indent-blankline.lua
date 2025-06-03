return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "▏",
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	},
	config = function(_, opts)
		require("ibl").setup(opts)
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#555557", nocombine = true })
	end,
}
