-- neorg
return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers", -- This is the important bit!
	version = "4.0.1",
	opts = {
		load = {
			["core.defaults"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						work = "~/notes/work",
						home = "~/notes/home",
					},
					default_workspace = "work",
				},
			},
			["core.concealer"] = {
				config = {
					folds = false,
				},
			},
		},
	},
}
