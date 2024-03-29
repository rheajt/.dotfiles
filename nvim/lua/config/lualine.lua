return require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "kanagawa",
		theme = "gruvbox-material",
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
		lualine_c = { { "filename", file_status = true, path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		-- lualine_c = {'filename'},
		-- lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {},
	},
	-- tabline = {
	-- 	lualine_a = { "branch" },
	-- 	lualine_b = { "buffers" },
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = { "tabs" },
	-- },
	extensions = {},
})
