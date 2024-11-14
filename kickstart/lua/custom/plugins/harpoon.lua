return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "abeldekat/harpoonline", version = "*" },
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<M-=>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<M-->", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })
			end,
		})

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next({ ui_nav_wrap = true })
		end)

		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev({ ui_nav_wrap = true })
		end)

		vim.keymap.set("n", "<leader>hh", function()
			require("harpoon.tmux").sendCommand(1, "ls<CR>")
		end)
	end,
}
