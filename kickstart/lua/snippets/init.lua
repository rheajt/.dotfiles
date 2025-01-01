local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local c = ls.choice_node

vim.keymap.set({ "i", "s" }, "<tab>", function()
	print("tab")
	if ls.expand_or_jumpable() then
		print("it is:: expand_or_jumpable")
		ls.expand_or_jump()
	end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<s-tab>", function()
	print("s-tab")
	if ls.jumpable(-1) then
		print("it is:: jumpable")
		ls.jump(-1)
	end
end, { expr = true })

ls.add_snippets("lua", {
	s("hello", {
		t('print("Hello, world!")'),
	}),
	s("locreq", {
		t("local "),
		i(1),
		t(" = require('"),
		i(2),
		t("')"),
	}),
})

ls.add_snippets("typescriptreact", {
	s("solid", {
		t("import { render } from 'solid-js/web';\n\n"),
		t("function ", i(1), "{\n"),
		t("    return (\n"),
		t("        <div>\n"),
		t("         ", rep(1), "\n"),
		t("        </div>\n"),
		t("    );\n"),
		t("}\n"),
		t("render(<", rep(1), "/>, document.getElementById('root'));\n"),
	}),
})
print("imported custom snippets")
