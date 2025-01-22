return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@diagnostic disable-next-line: undefined-doc-name
	---@type ibl.config
	---@diagnostic disable-next-line: assign-type-mismatch
	config = function()
		require("ibl").setup({})
	end,
}
