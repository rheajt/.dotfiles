local ok, ls = pcall(require, "luasnip")

if not ok then
	print("snippets not ok")
	return
end

ls.snippets = {
	all = {
		ls.parser.parse_snippet("clg", "console.log({${1:text}});"),

		-- When wordTrig is set to false, snippets may also expand inside other words.
		-- ls.parser.parse_snippet({ trig = "te", wordTrig = false }, "${1:cond} ? ${2:true} : ${3:false}"),

		-- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
		-- ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
	},
}

print("these snippets are loaded")
