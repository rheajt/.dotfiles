-- neorg
return {
	{
		"nvim-neorg/neorg",
		version = "*",
		-- put any other flags you wanted to pass to lazy here!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
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
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.journal"] = {
						config = {
							journal_folder = "journal",
							strategy = "nested",
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

			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "norg",
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>ps",
						":Neorg presenter start<CMD>",
						{ desc = "[P]resentation [S]tart", buffer = true }
					)
					vim.keymap.set("n", "<leader>nt", "^i- ( ) <Esc>", { desc = "[N]ew [T]ask", buffer = true })
					vim.keymap.set(
						"n",
						"<right>",
						"<Plug>(neorg.presenter.next-page)",
						{ desc = "Presentation Next Page", buffer = true }
					)
					vim.keymap.set(
						"n",
						"<left>",
						"<Plug>(neorg.presenter.previous-page)",
						{ desc = "Presentation Previous Page", buffer = true }
					)
				end,
			})
			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
}
