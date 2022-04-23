local ok, ls = pcall(require, "luasnip")

if not ok then
	print("snippets not ok")
	return
end

require("luasnip.loaders.from_vscode").lazy_load()

ls.snippets = {
	all = {},
	go = {
		ls.parser.parse_snippet("fn", "func ${1:name}() {${0}}"),
		ls.parser.parse_snippet("clg", "fmt.Println(${1})"),
	},
}
