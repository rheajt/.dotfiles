-- neorg
return {
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		-- put any other flags you wanted to pass to lazy here!
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.keybinds"] = {
					config = {
						default_keybinds = true,
						neorg_leader = "<leader>",
					},
				},
				-- ["core.export"] = {},
				-- ["core.export.markdown"] = { config = { extensions = "all" } },
				-- ["core.esupports.metagen"] = { config = { type = "empty", update_date = true } },
				-- ["core.clipboard.code-blocks"] = {},
				-- ["core.qol.toc"] = {},
				-- ["core.qol.todo_items"] = {
				-- 	config = {
				-- 		create_todo_items = true,
				-- 		create_todo_parents = true,
				-- 	},
				-- },
				-- ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
				-- ["core.journal"] = {
				-- 	config = {
				-- 		journal_folder = "journal",
				-- 		strategy = "nested",
				-- 	},
				-- },
				["core.dirman"] = {
					config = {
						workspaces = {
							notes = "~/Insync/rheajt@gmail.com/drive/notes",
						},
						default_workspace = "notes",
					},
				},
				-- ["core.summary"] = {},
			},
		},
		config = function()
			vim.keymap.set("n", "<leader>nt", "[[^i- ( ) <Esc>]]", { desc = "[N]ew [T]ask" })
			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
}
