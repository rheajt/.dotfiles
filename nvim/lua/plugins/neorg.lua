-- neorg
return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers", -- This is the important bit!
	opts = {
		load = {
			["core.defaults"] = {},
			["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
			["core.integrations.nvim-cmp"] = {},
			["core.concealer"] = {
				config = {
					folds = false,
					icon_preset = "diamond",
				},
			},
			["core.keybinds"] = {
				config = {
					default_keybinds = true,
					neorg_leader = "<leader><leader>",
				},
			},
			["core.export"] = {},
			["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
			["core.clipboard.code-blocks"] = {},
			["core.qol.toc"] = {},
			["core.qol.todo_items"] = {},
			["core.looking-glass"] = {},
			["core.presenter"] = { config = { zen_mode = "zen-mode" } },
			["core.journal"] = {
				config = {
					strategy = "flat",
					workspace = "work",
				},
			},
			["core.dirman"] = {
				config = {
					workspaces = {
						work = "~/notes/work",
						home = "~/notes/home",
					},
					default_workspace = "work",
				},
			},
		},
	},
}
