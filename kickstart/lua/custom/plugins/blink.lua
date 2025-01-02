return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		-- sources = {
		-- 	default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		-- 	providers = {
		-- 		lazydev = {
		-- 			name = "LazyDev",
		-- 			module = "lazydev.integrations.blink",
		-- 			-- make lazydev completions top priority (see `:h blink.cmp`)
		-- 			score_offset = 100,
		-- 		},
		-- 		lsp = {
		-- 			name = "LSP",
		-- 			module = "cmp_nvim_lsp",
		-- 			-- make LSP completions second priority
		-- 			score_offset = 99,
		-- 		},
		-- 		path = {
		-- 			name = "Path",
		-- 			module = "cmp_path",
		-- 			-- make path completions third priority
		-- 			score_offset = 25,
		-- 		},
		-- 		snippets = {
		-- 			name = "Snippets",
		-- 			module = "cmp_tabnine",
		-- 			-- make snippets completions fourth priority
		-- 			score_offset = 10,
		-- 		},
		-- 		buffer = {
		-- 			name = "Buffer",
		-- 			module = "cmp_tabnine",
		-- 			-- make buffer completions fifth priority
		-- 			score_offset = 5,
		-- 		},
		-- 	},
		-- },
		signature = {
			enabled = true,
		},
	},
}
