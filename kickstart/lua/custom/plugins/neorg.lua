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
					["core.export.markdown"] = { config = { extensions = "all" } },
					["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
					["core.clipboard.code-blocks"] = {},
					["core.qol.toc"] = {},
					["core.qol.todo_items"] = {
						config = {
							create_todo_items = true,
							create_todo_parents = true,
						},
					},
					["core.looking-glass"] = {},
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.journal"] = {
						config = {
							journal_folder = "journal",
							strategy = "flat",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Insync/rheajt@gmail.com/drive/notes",
							},
							default_workspace = "notes",
						},
					},
					["core.summary"] = {},
				},
			})
			vim.api.nvim_set_keymap("n", "<leader>tt", [[^i- ( ) <Esc>]], { noremap = true, silent = true })
		end,
		keys = {
			{
				"n",
				"<leader>jb",
				function()
					print("journal index")
				end,
				{ noremap = true },
			},
		},
	},
}
