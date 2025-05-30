return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes -- comment = 'gc',

		-- Toggle comment on current line comment_line = 'gcc',

		-- Toggle comment on visual selection comment_visual = 'gc',

		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		-- Works also in Visual mode if mapping differs from `comment_visual`
		-- textobject = 'gc',
		require("mini.comment").setup()
	end,
}
