return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		vim.keymap.set("n", "<leader>ha", function()
			require("harpoon.mark").add_file()
		end)

		vim.keymap.set("n", "<leader>hm", function()
			require("harpoon.ui").toggle_quick_menu()
		end)

		vim.keymap.set("n", "<leader>hf", ":Telescope harpoon marks<CR>")

		vim.keymap.set("n", "<leader><leader>n", function()
			require("harpoon.ui").nav_next()
		end)

		vim.keymap.set("n", "<leader><leader>p", function()
			require("harpoon.ui").nav_prev()
		end)

		-- vim.keymap.set("n", "<leader>hh", function()
		-- 	require("harpoon.tmux").sendCommand(1, "ls<CR>")
		-- end)
	end,
}
