---@module "lazy"
---@type LazySpec
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 2500,
				async = false,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- javascript = { 'prettierd', 'prettier', stop_after_first = true },
			cs = { "csharpier" },
			json = { "prettier" },
			yaml = { "prettier" },
			xml = { "xmlformatter" },
		},
		formaters = {
			cshrapier = {
				command = "csharpier",
				args = {
					"format",
					"--write-stdout",
				},
				to_stdin = true,
				-- args = { "--write-stdout", "$FILENAME" },
			},
		},
	},
}
