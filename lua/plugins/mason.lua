return {
	"mason-org/mason.nvim",
	opts = {
		registries = {
			"github:mason-org/mason-registry",
			"github:crashdummyy/mason-registry",
		},
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
