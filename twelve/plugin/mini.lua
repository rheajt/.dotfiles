-- mini.basics is intentionally omitted -- settings.lua covers all its options.
-- surround/ai/comment are deferred to UIEnter since they are editing helpers.
vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
})

vim.schedule(function()
	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
	-- - sd'   - [S]urround [D]elete [']quotes
	-- - sr)'  - [S]urround [R]eplace [)] [']
	require("mini.surround").setup()

	-- Better Around/Inside textobjects
	-- Examples:
	--  - va)  - [V]isually select [A]round [)]paren
	--  - yinq - [Y]ank [I]nside [N]ext [']quote
	--  - ci'  - [C]hange [I]nside [']quote
	require("mini.ai").setup({ n_lines = 500 })

	require("mini.comment").setup()

	-- required for statusline
	require("mini.git").setup()
	require("mini.diff").setup()

	require("mini.statusline").setup({
		theme = "gruvbox",
		content = {
			active = function()
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
				local git = MiniStatusline.section_git({ trunc_width = 40 })
				local diff = MiniStatusline.section_diff({ trunc_width = 75 })
				local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
				local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
				local filename = MiniStatusline.section_filename({ trunc_width = 140 })
				local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
				local location = MiniStatusline.section_location({ trunc_width = 75 })
				local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

				local filename_hl = vim.bo.modified and "MiniStatuslineFilenameModified" or "MiniStatuslineFilename"

				return MiniStatusline.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
					"%<",
					{ hl = filename_hl, strings = { filename } },
					"%=",
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					{ hl = mode_hl, strings = { search, location } },
				})
			end,
		},
		use_icons = true,
	})

	-- Gruvbox yellow background for modified files
	vim.api.nvim_set_hl(0, "MiniStatuslineFilenameModified", { fg = "#1d2021", bg = "#d79921", bold = true })
	-- White filename text for unmodified files
	vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = "#ffffff" })
end)
