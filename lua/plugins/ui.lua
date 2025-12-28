---@module "lazy"
---@type LazySpec
return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		enabled = true,

		config = function()
			-- Custom Lualine component to show attached language server
			-- local clients_lsp = function()
			-- 	-- local bufnr = vim.api.nvim_get_current_buf()
			-- 	local clients = vim.lsp.get_clients()
			-- 	if next(clients) == nil then
			-- 		return ""
			-- 	end
			-- 	local c = {}
			-- 	for _, client in pairs(clients) do
			-- 		table.insert(c, client.name)
			-- 	end
			-- 	return " " .. table.concat(c, " | ")
			-- end

			require("lualine").setup({
				options = {
					theme = "monokai-pro",
					-- component_separators = "",
					-- section_separators = { left = "", right = "" },
					-- disabled_filetypes = { "alpha", "Outline" },
				},
				-- sections = {
				-- 	lualine_a = {
				-- 		{ "mode", separator = { left = "", right = "" }, icon = "" },
				-- 	},
				-- 	lualine_b = {
				-- 		{
				-- 			"filetype",
				-- 			icon_only = true,
				-- 			padding = { left = 1, right = 0 },
				-- 		},
				-- 		"filename",
				-- 	},
				-- 	lualine_c = {
				-- 		{
				-- 			"branch",
				-- 			icon = "",
				-- 		},
				-- 		{
				-- 			"diff",
				-- 			symbols = { added = "+ ", modified = "~ ", removed = "_ " },
				-- 			colored = true,
				-- 		},
				-- 	},
				-- 	lualine_x = {
				-- 		{
				-- 			"diagnostics",
				-- 			symbols = { error = " ", warn = " ", info = " ", hint = " " },
				-- 			update_in_insert = true,
				-- 		},
				-- 	},
				-- 	lualine_y = { clients_lsp },
				-- 	lualine_z = {
				-- 		{ "location", separator = { left = "", right = "" }, icon = "" },
				-- 	},
				-- },

				-- inactive_sections = {
				-- 	lualine_a = { "filename" },
				-- 	lualine_b = {},
				-- 	-- lualine_c = { "branch", "diff" },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = { "location" },
				-- },
				-- extensions = { "toggleterm", "trouble" },
			})
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				setopt = true,
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { " ", "%s" }, click = "v:lua.ScSa" },
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
				},
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "User FilePost",
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
	},
}
