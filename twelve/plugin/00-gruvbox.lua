vim.pack.add({
	-- "https://github.com/luisiacc/gruvbox-baby",
	"https://github.com/metalelf0/kintsugi-nvim",
})
require("kintsugi").setup({
	variant = "flared", -- "dark" | "flared"
	transparent = true,
	terminal_colors = true,
	bold_keywords = true,
	italic_comments = true,
})
vim.cmd.colorscheme("kintsugi-flared") -- or "kintsugi-flared"

-- vim.g.gruvbox_baby_transparent_mode = true
-- vim.g.gruvbox_baby_background_color = "dark"
-- vim.cmd.colorscheme("gruvbox-baby")
