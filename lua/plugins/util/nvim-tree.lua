local M = {}

M.on_attach = function(bufnr)
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
	api.map.on_attach.default(bufnr)

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
	-- local dotnet = require("easy-dotnet")
	-- if dotnet.is_dotnet_project() then
	-- 	vim.keymap.set("n", "A", function()
	-- 		local node = api.tree.get_node_under_cursor()
	-- 		local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
	-- 		print(path)
	-- 		dotnet.create_new_item(path)
	-- 	end, opts("Create file from dotnet template"))
	-- end
end

return M
