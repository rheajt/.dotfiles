vim.pack.add({
	"https://github.com/nvim-zh/colorful-winsep.nvim",
})

require("colorful-winsep").setup({
	border = "bold",
	excluded_ft = { "packer", "TelescopePrompt", "mason" },
	highlight = nil,
	animate = {
		enabled = "shift",
		shift = {
			delta_time = 0.1,
			smooth_speed = 1,
			delay = 3,
		},
		progressive = {
			vertical_delay = 20,
			horizontal_delay = 2,
		},
	},
	indicator_for_2wins = {
		position = "center",
		symbols = {
			start_left = "󱞬",
			end_left = "󱞪",
			start_down = "󱞾",
			end_down = "󱟀",
			start_up = "󱞢",
			end_up = "󱞤",
			start_right = "󱞨",
			end_right = "󱞦",
		},
	},
})
