local ok, ls = pcall(require, "luasnip")

if not ok then
	print("snippets not ok")
	return
end

-- some shorthands...
local snippet_node = ls.snippet
local snip_node = ls.snippet_node
local text_node = ls.text_node
local insert_node = ls.insert_node
local choice_node = ls.choice_node
local dynamic_node = ls.dynamic_node
local types = require("luasnip.util.types")

require("luasnip/loaders/from_vscode").lazy_load()
-- Every unspecified option will be set to the default.
ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
	return snip_node(
		nil,
		choice_node(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			text_node(""),
			snip_node(nil, { text_node({ "", "\t\\item " }), insert_node(1), dynamic_node(2, rec_ls, {}) }),
		})
	)
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

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
ls.autosnippets = {
	all = {
		snippet_node("autotrigger", {
			text_node("autosnippet"),
		}),
	},
}

print("these snippets are loaded")
