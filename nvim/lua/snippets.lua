local ls = require("luasnip")
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
	return { os.date("%Y-%m-%d") }
end

ls.add_snippets(nil, {
	all = {
		snip({
			trig = "date",
			namr = "Date",
			dscr = "Date in the form of YYYY-MM-DD",
		}, {
			func(date, {}),
		}),
	},
	markdown = {
		snip({
			trig = "blog_meta",
			namr = "Metadata",
			dscr = "Yaml metadata format for markdown blog post",
		}, {
			text({ "---", "draft: true" }),
			text({ "", "title: " }),
			insert(1, "title"),
			text({ "", "date: " }),
			func(date, {}),
			text({ "", "categories: [Blog," }),
			insert(2, "blog_categories"),
			text({ "]", "" }),
			text({ "tags: [" }),
			insert(3, "tags"),
			text({ "]" }),
			text({ "", "image: ../../default-code.png" }),
			text({ "", "youtube: " }),
			insert(4, "youtube_url"),
			text({ "", "---" }),
			insert(0),
		}),
	},
	typescript = {
		snip({
			trig = "clg",
			namr = "console log",
			dscr = "quick console log statement",
		}, {
			text({ "console.log({" }),
			insert(1, "VAR"),
			text("});"),
			insert(0),
		}),
	},
	javascript = {
		snip({
			trig = "clg",
			namr = "console log",
			dscr = "quick console log statement",
		}, {
			text({ "console.log({" }),
			insert(1, "VAR"),
			text("});"),
			insert(0),
		}),
	},
	typescriptreact = {
		snip({
			trig = "clg",
			namr = "console log",
			dscr = "quick console log statement",
		}, {
			text({ "console.log({" }),
			insert(1, "VAR"),
			text("});"),
			insert(0),
		}),
	},
})

require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/snippets.lua<CR>")

print("snippets loaded")
