-- neorg
return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim", "nvim-treesitter/nvim-treesitter" },
		lazy = false,
		-- put any other flags you wanted to pass to lazy here!
		config = function()
			require("neorg").setup({
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
							neorg_leader = "<leader>",
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
								work = "~/Insync/rheajt@gmail.com/Google\\ Drive/notes/work",
								home = "~/Insync/rheajt@gmail.com/Google\\ Drive/notes/home",
							},
							default_workspace = "work",
						},
					},
				},
			})
		end,
	},
}
