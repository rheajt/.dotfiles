local ok, ls = pcall(require, "luasnip")

if not ok then
	print("snippets not ok")
	return
end

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

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

require("luasnip.loaders.from_vscode").lazy_load()
