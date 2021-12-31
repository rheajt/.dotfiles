local present, cmp = pcall(require, "cmp")

if not present then
	print("hello world")
	return
end

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
cmp.setup({
	snippet = {
		expand = function(args)
			local luasnip = require("luasnip")
			if not luasnip then
				return
			end
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = false,
			maxwidth = 50,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[LUA]",
				luasnip = "[Snippets]",
				path = "[Path]",
				buffer = "[buf]",
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
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	experimental = {
		native_menu = false,
		ghost_menu = true,
	},
})
