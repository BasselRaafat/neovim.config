---@module "lazy"
---@type LazySpec
return {
	"barrettruth/live-server.nvim",
	enabled = false,
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
}
