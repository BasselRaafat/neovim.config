return {
	"Jezda1337/nvim-html-css",
	enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		enable_on = {
			"html",
			"htmldjango",
			"tsx",
			"jsx",
			"erb",
			"svelte",
			"vue",
			"blade",
			"php",
			"templ",
			"astro",
			"htmlangular",
		},
		style_sheets = {
			"./node_modules/bootstrap/dist/css/bootstrap.min.css",
			"./node_modules/bootstrap-icons/font/bootstrap-icons.min.css",
			-- "./index.css", -- `./` refers to the current working directory.
		},
	},
}
