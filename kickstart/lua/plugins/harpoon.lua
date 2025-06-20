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
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-x>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })
			end,
		})

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>hh", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>hk", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>hl", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>h;", function()
			harpoon:list():select(4)
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
	end,
}
