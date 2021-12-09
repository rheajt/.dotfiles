local ls = require("luasnip")
-- some shorthands...
local snippet_node = ls.snippet
local snip_node = ls.snippet_node
local text_node = ls.text_node
local insert_node = ls.insert_node
local func_node = ls.function_node
local choice_node = ls.choice_node
local dynamic_node = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

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

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

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

-- complicated function for dynamicNode.
local function jdocsnip(args, _, old_state)
	local nodes = {
		text_node({ "/**", " * " }),
		insert_node(1, "A short Description"),
		text_node({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = insert_node(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { text_node({ " * ", "" }) })
	end

	local insert = 2
	for _, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state[arg] then
				inode = insert_node(insert, old_state["arg" .. arg]:get_text())
			else
				inode = insert_node(insert)
			end
			vim.list_extend(nodes, { text_node({ " * @param " .. arg .. " " }), inode, text_node({ "", "" }) })
			param_nodes["arg" .. arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = insert_node(insert, old_state.ret:get_text())
		else
			inode = insert_node(insert)
		end

		vim.list_extend(nodes, { text_node({ " * ", " * @return " }), inode, text_node({ "", "" }) })
		param_nodes.ret = inode
		insert = insert + 1
	end

	if vim.tbl_count(args[3]) ~= 1 then
		local exc = string.gsub(args[3][2], " throws ", "")
		local ins
		if old_state and old_state.ex then
			ins = insert_node(insert, old_state.ex:get_text())
		else
			ins = insert_node(insert)
		end
		vim.list_extend(nodes, { text_node({ " * ", " * @throws " .. exc .. " " }), ins, text_node({ "", "" }) })
		param_nodes.ex = ins
		insert = insert + 1
	end

	vim.list_extend(nodes, { text_node({ " */" }) })

	local snip = snip_node(nil, nodes)
	-- Error on attempting overwrite.
	snip.old_state = param_nodes
	return snip
end

-- Make sure to not pass an invalid command, as io.popen() may write over nvim-text.
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

-- Returns a snippet_node wrapped around an insert_node whose initial
-- text value is set to the current date in the desired format.
local date_input = function(args, state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return snip_node(nil, insert_node(1, os.date(fmt)))
end

ls.snippets = {
	-- When trying to expand a snippet, luasnip first searches the tables for
	-- each filetype specified in 'filetype' followed by 'all'.
	-- If ie. the filetype is 'lua.c'
	--     - luasnip.lua
	--     - luasnip.c
	--     - luasnip.all
	-- are searched in that order.
	all = {
		-- trigger is fn.
		snippet_node("fn", {
			-- Simple static text.
			text_node("//Parameters: "),
			-- function, first parameter is the function, second the Placeholders
			-- whose text it gets as input.
			func_node(copy, 2),
			text_node({ "", "function " }),
			-- Placeholder/Insert.
			insert_node(1),
			text_node("("),
			-- Placeholder with initial text.
			insert_node(2, "int foo"),
			-- Linebreak
			text_node({ ") {", "\t" }),
			-- Last Placeholder, exit Point of the snippet. EVERY 'outer' SNIPPET NEEDS Placeholder 0.
			insert_node(0),
			text_node({ "", "}" }),
		}),
		-- Parsing snippets: First parameter: Snippet-Trigger, Second: Snippet body.
		-- Placeholders are parsed into choices with 1. the placeholder text(as a snippet) and 2. an empty string.
		-- This means they are not SELECTed like in other editors/Snippet engines.
		ls.parser.parse_snippet("lspsyn", "Wow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"),

		-- When wordTrig is set to false, snippets may also expand inside other words.
		ls.parser.parse_snippet({ trig = "te", wordTrig = false }, "${1:cond} ? ${2:true} : ${3:false}"),

		-- When regTrig is set, trig is treated like a pattern, this snippet will expand after any number.
		ls.parser.parse_snippet({ trig = "%d", regTrig = true }, "A Number!!"),
		-- Using the condition, it's possible to allow expansion only in specific cases.
		-- snippet_node("cond", {
		-- 	text_node("will only expand in c-style comments"),
		-- }, {
		-- 	condition = function(line_to_cursor, matched_trigger, captures)
		-- 		-- optional whitespace followed by //
		-- 		return line_to_cursor:match("%s*//")
		-- 	end,
		-- }),
		-- there's some built-in conditions in "luasnip.extras.expand_conditions".
		-- snippet_node("cond2", {
		-- 	text_node("will only expand at the beginning of the line"),
		-- }, {
		-- 	condition = conds.line_begin,
		-- }),
		-- The last entry of args passed to the user-function is the surrounding snippet.
		-- snippet_node(
		-- 	{ trig = "a%d", regTrig = true },
		-- 	func_node(function(_, snip)
		-- 		return "Triggered with " .. snip.trigger .. "."
		-- 	end, {})
		-- ),
		-- It's possible to use capture-groups inside regex-triggers.
		-- snippet_node(
		-- 	{ trig = "b(%d)", regTrig = true },
		-- 	func_node(function(_, snip)
		-- 		return "Captured Text: " .. snip.captures[1] .. "."
		-- 	end, {})
		-- ),
		-- snippet_node({ trig = "c(%d+)", regTrig = true }, {
		-- 	text_node("will only expand for even numbers"),
		-- }, {
		-- 	condition = function(line_to_cursor, matched_trigger, captures)
		-- 		return tonumber(captures[1]) % 2 == 0
		-- 	end,
		-- }),
		-- Use a function to execute any shell command and print its text.
		-- snippet_node("bash", func_node(bash, {}, "ls")),
		-- Short version for applying String transformations using function nodes.
		-- snippet_node("transform", {
		-- 	insert_node(1, "initial text"),
		-- 	text_node({ "", "" }),
		-- 	-- lambda nodes accept an l._1,2,3,4,5, which in turn accept any string transformations.
		-- 	-- This list will be applied in order to the first node given in the second argument.
		-- 	l(l._1:match("[^i]*$"):gsub("i", "o"):gsub(" ", "_"):upper(), 1),
		-- }),
		-- snippet_node("transform2", {
		-- 	insert_node(1, "initial text"),
		-- 	text_node("::"),
		-- 	insert_node(2, "replacement for e"),
		-- 	text_node({ "", "" }),
		-- 	-- Lambdas can also apply transforms USING the text of other nodes:
		-- 	l(l._1:gsub("e", l._2), { 1, 2 }),
		-- }),
		-- snippet_node({ trig = "trafo(%d+)", regTrig = true }, {
		-- 	-- env-variables and captures can also be used:
		-- 	l(l.CAPTURE1:gsub("1", l.TM_FILENAME), {}),
		-- }),
		-- Set store_selection_keys = "<Tab>" (for example) in your
		-- luasnip.config.setup() call to access TM_SELECTED_TEXT. In
		-- this case, select a URL, hit Tab, then expand this snippet.
		-- snippet_node("link_url", {
		-- 	text_node('<a href="'),
		-- 	func_node(function(_, snip)
		-- 		return snip.env.TM_SELECTED_TEXT[1] or {}
		-- 	end, {}),
		-- 	text_node('">'),
		-- 	insert_node(1),
		-- 	text_node("</a>"),
		-- 	insert_node(0),
		-- }),
		-- Shorthand for repeating the text in a given node.
		-- snippet_node("repeat", { insert_node(1, "text"), text_node({ "", "" }), r(1) }),
		-- Directly insert the ouput from a function evaluated at runtime.
		-- snippet_node("part", p(os.date, "%Y")),
		-- use matchNodes to insert text based on a pattern/function/lambda-evaluation.
		-- snippet_node("mat", {
		-- 	insert_node(1, { "sample_text" }),
		-- 	text_node(": "),
		-- 	m(1, "%d", "contains a number", "no number :("),
		-- }),
		-- The inserted text defaults to the first capture group/the entire
		-- match if there are none
		-- snippet_node("mat2", {
		-- 	insert_node(1, { "sample_text" }),
		-- 	text_node(": "),
		-- 	m(1, "[abc][abc][abc]"),
		-- }),
		-- It is even possible to apply gsubs' or other transformations
		-- before matching.
		-- snippet_node("mat3", {
		-- 	insert_node(1, { "sample_text" }),
		-- 	text_node(": "),
		-- 	m(1, l._1:gsub("[123]", ""):match("%d"), "contains a number that isn't 1, 2 or 3!"),
		-- }),
		-- `match` also accepts a function, which in turn accepts a string
		-- (text in node, \n-concatted) and returns any non-nil value to match.
		-- If that value is a string, it is used for the default-inserted text.
		-- snippet_node("mat4", {
		-- 	insert_node(1, { "sample_text" }),
		-- 	text_node(": "),
		-- 	m(1, function(text)
		-- 		return (#text % 2 == 0 and text) or nil
		-- 	end),
		-- }),
		-- The nonempty-node inserts text depending on whether the arg-node is
		-- empty.
		-- snippet_node("nempty", {
		-- 	insert_node(1, "sample_text"),
		-- 	n(1, "i(1) is not empty!"),
		-- }),
		-- dynamic lambdas work exactly like regular lambdas, except that they
		-- don't return a textNode, but a dynamicNode containing one insertNode.
		-- This makes it easier to dynamically set preset-text for insertNodes.
		-- snippet_node("dl1", {
		-- 	insert_node(1, "sample_text"),
		-- 	text_node({ ":", "" }),
		-- 	dl(2, l._1, 1),
		-- }),
		-- Obviously, it's also possible to apply transformations, just like lambdas.
		-- snippet_node("dl2", {
		-- 	insert_node(1, "sample_text"),
		-- 	insert_node(2, "sample_text_2"),
		-- 	text_node({ "", "" }),
		-- 	dl(3, l._1:gsub("\n", " linebreak ") .. l._2, { 1, 2 }),
		-- }),
		-- Alternative printf-like notation for defining snippets. It uses format
		-- string with placeholders similar to the ones used with Python's .format().
		-- snippet_node(
		-- 	"fmt1",
		-- 	fmt("To {title} {} {}.", {
		-- 		insert_node(2, "Name"),
		-- 		insert_node(3, "Surname"),
		-- 		title = choice_node(1, { text_node("Mr."), text_node("Ms.") }),
		-- 	})
		-- ),
		-- To escape delimiters use double them, e.g. `{}` -> `{{}}`.
		-- Multi-line format strings by default have empty first/last line removed.
		-- Indent common to all lines is also removed. Use the third `opts` argument
		-- to control this behaviour.
		-- snippet_node(
		-- 	"fmt2",
		-- 	fmt(
		-- 		[[
		-- 	foo({1}, {3}) {{
		-- 		return {2} * {4}
		-- 	}}
		-- 	]],
		-- 		{
		-- 			insert_node(1, "x"),
		-- 			r(1),
		-- 			insert_node(2, "y"),
		-- 			r(2),
		-- 		}
		-- 	)
		-- ),
		-- Empty placeholders are numbered automatically starting from 1 or the last
		-- value of a numbered placeholder. Named placeholders do not affect numbering.
		-- snippet_node(
		-- 	"fmt3",
		-- 	fmt("{} {a} {} {1} {}", {
		-- 		text_node("1"),
		-- 		text_node("2"),
		-- 		a = text_node("A"),
		-- 	})
		-- ),
		-- The delimiters can be changed from the default `{}` to something else.
		-- snippet_node("fmt4", fmt("foo() { return []; }", insert_node(1, "x"), { delimiters = "[]" })),
		-- `fmta` is a convenient wrapper that uses `<>` instead of `{}`.
		-- snippet_node("fmt5", fmta("foo() { return <>; }", insert_node(1, "x"))),
		-- By default all args must be used. Use strict=false to disable the check
		-- snippet_node("fmt6", fmt("use {} only", { text_node("this"), text_node("not this") }, { strict = false })),
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

-- in a lua file: search lua-, then c-, then all-snippets.
ls.filetype_extend("lua", { "c" })
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
ls.filetype_set("cpp", { "c" })

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

require("luasnip/loaders/from_vscode").load({ include = { "python" } }) -- Load only python snippets
-- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
-- a similar `package.json`)
require("luasnip/loaders/from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
