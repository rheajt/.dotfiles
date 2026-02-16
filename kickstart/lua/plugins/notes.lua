return {
	{
		-- This is my own custom plugin, not published on GitHub, so I use the full path to the plugin directory.
		dir = "/home/jordanrhea/projects/nvim/organize-tasks",
		opts = {},
	},

	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "Vault",
				path = "~/Insync/rheajt@gmail.com/drive/Obsidian/",
			},
		},

		-- see below for full list of options 👇
	},
	-- INFO: old neorg config, keeping it here for reference
	--    {
	-- 	"nvim-neorg/neorg",
	-- 	version = "*",
	-- 	-- put any other flags you wanted to pass to lazy here!
	-- 	config = function()
	-- 		require("neorg").setup({
	-- 			load = {
	-- 				["core.defaults"] = {},
	-- 				["core.concealer"] = {},
	-- 				["core.keybinds"] = {
	-- 					config = {
	-- 						default_keybinds = true,
	-- 						neorg_leader = "<leader>",
	-- 					},
	-- 				},
	-- 				["core.export"] = {
	-- 					config = {
	-- 						export_dir = "~/vault",
	-- 					},
	-- 				},
	-- 				["core.export.markdown"] = { config = { extensions = "all" } },
	-- 				["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
	-- 				["core.clipboard.code-blocks"] = {},
	-- 				["core.qol.toc"] = {},
	-- 				["core.qol.todo_items"] = {
	-- 					config = {
	-- 						create_todo_items = true,
	-- 						create_todo_parents = true,
	-- 					},
	-- 				},
	-- 				["core.presenter"] = { config = { zen_mode = "zen-mode" } },
	-- 				["core.journal"] = {
	-- 					config = {
	-- 						journal_folder = "journal",
	-- 						strategy = "nested",
	-- 					},
	-- 				},
	-- 				["core.dirman"] = {
	-- 					config = {
	-- 						workspaces = {
	-- 							notes = "~/Insync/rheajt@gmail.com/drive/notes",
	-- 						},
	-- 						default_workspace = "notes",
	-- 					},
	-- 				},
	-- 				["core.summary"] = {},
	-- 			},
	-- 		})
	--
	-- 		vim.api.nvim_create_autocmd("Filetype", {
	-- 			pattern = "norg",
	-- 			callback = function()
	-- 				local wk = require("which-key")
	-- 				local bufnr = vim.api.nvim_get_current_buf()
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"<leader>ps",
	-- 					":Neorg presenter start<CMD>",
	-- 					{ desc = "[P]resentation [S]tart", buffer = true }
	-- 				)
	-- 				vim.keymap.set("n", "<leader>nt", "^i- ( ) <Esc>", { desc = "[N]ew [T]ask", buffer = true })
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"<right>",
	-- 					"<Plug>(neorg.presenter.next-page)",
	-- 					{ desc = "Presentation Next Page", buffer = true }
	-- 				)
	-- 				vim.keymap.set(
	-- 					"n",
	-- 					"<left>",
	-- 					"<Plug>(neorg.presenter.previous-page)",
	-- 					{ desc = "Presentation Previous Page", buffer = true }
	-- 				)
	--
	-- 				wk.add({
	-- 					{ "<leader>ps", desc = "[P]resentation [S]tart" },
	-- 					{ "<leader>nt", desc = "[N]ew [T]ask" },
	-- 				}, { buffer = bufnr })
	-- 			end,
	-- 		})
	-- 		vim.wo.foldlevel = 99
	-- 		vim.wo.conceallevel = 2
	-- 	end,
	-- }
}
