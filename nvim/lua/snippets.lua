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
