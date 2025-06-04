return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = "VeryLazy",
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			["<Up>"] = {},
			["<Down>"] = {},
		},
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
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
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
