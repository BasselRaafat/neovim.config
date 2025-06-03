-- local _, nvim_tree = pcall(require, "nvim-tree")
-- local ok, tree_config = pcall(require, "nvim-tree.config")
-- if not ok then
-- 	return {}
-- end
-- local tree_cb = tree_config.nvim_tree_callback
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	local function opts_without_buffer(desc)
		return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
	end
	-- copy default mappings here from defaults in next section
	--vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	--vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	---
	-- OR use all default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- remove a default
	--vim.keymap.del("n", "<C-]>", { buffer = bufnr })

	-- override a default
	--vim.keymap.set("n", "<C-e>", api.tree.reload, opts("Refresh"))

	-- add your mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open Node"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open Node"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Node"))
	vim.keymap.set("n", "<leader>tt", api.tree.toggle, opts_without_buffer("[T]oggle [T]ree"))
	vim.keymap.set("n", "<leader>tr", api.tree.reload, opts_without_buffer("[T]Refresh [R]Tree"))
	vim.keymap.set("n", "A", function()
		local node = api.tree.get_node_under_cursor()
		vim.print(node)
		local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
		vim.print(path)
		require("easy-dotnet").create_new_item(path)
	end, opts("Create file from dotnet template"))
end
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	priority = 2000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"GustavEikaas/easy-dotnet.nvim",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			hijack_cursor = true,
			view = {
				side = "right",
				cursorline = true,
			},
			renderer = {
				root_folder_label = ":~:s?$?/..?",
				indent_markers = {
					enable = true,
					inline_arrows = true,
				},
				icons = {
					web_devicons = {
						folder = {
							enable = false,
						},
					},
				},
			},
			git = {
				timeout = 1550,
			},
			diagnostics = {
				debounce_delay = 1000,
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
				icons = {
					error = "",
				},
			},
			live_filter = {
				prefix = "[FILTER]: ",
			},
			notify = {
				absolute_path = true,
			},
		})
	end,
}
