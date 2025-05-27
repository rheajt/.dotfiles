return {
	"saghen/blink.cmp",
	dependencies = { "fang2hou/blink-copilot", "rafamadriz/friendly-snippets" },
	event = "VeryLazy",
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				["Copilot"] = "",
				["Snip"] = "",
				["Snippet"] = "",
			},
		},
		completion = {
			menu = {
				border = "single",
				draw = {
					padding = { 2, 2 },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = false,
			},
		},
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "copilot", "buffer" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 1,
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = { "sources.default" },
}
