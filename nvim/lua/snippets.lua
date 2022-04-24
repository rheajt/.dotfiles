local ok, ls = pcall(require, "luasnip")

if not ok then
	print("snippets not ok")
	return
end

require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
print("snippets here")
ls.snippets = {
	all = {
		ls.parser.parse_snippet("expand", "-- this is what is expanded"),
	},
	lua = {
		ls.parser.parse_snippet("lf", "local $1 = function($2)\n  $0\nend"),
	},
	go = {
		ls.parser.parse_snippet("clg", "fmt.Println(${1})"),
	},
}
