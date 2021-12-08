local present, cmp = pcall(require, "cmp")

if not present then
	return
end

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
cmp.setup({
	-- snippet = {
	--   expand = function(args)
	--     require'luasnip'.lsp_expand(args.body)
	--   end
	-- },
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = false,
			maxwidth = 50,
			menu = {
				buffer = "[buf}",
				nvim_lsp = "[LSP]",
			},
		}),
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		-- { name = "luasnip"},
		{ name = "nvim_lua" },
		{ name = "buffer", keyword_length = 5 },
	},
	experimental = {
		native_menu = false,
		ghost_menu = true,
	},
})
