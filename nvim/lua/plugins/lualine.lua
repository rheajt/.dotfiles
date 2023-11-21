-- Status Line
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox_dark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				-- component_separators = { left = '', right = ''},
				-- section_separators = { left = '', right = ''},
				disabled_filetypes = { "NvimTree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
				lualine_c = { { "filename", file_status = true, path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress", "location" },
				lualine_z = { "tabs" },
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
			-- 	lualine_a = {},
			-- 	lualine_a = { "buffers" },
			-- 	lualine_b = {},
			-- 	lualine_c = {},
			-- 	lualine_x = {},
			-- 	lualine_y = { "branch" },
			-- 	lualine_z = { "tabs" },
			-- },
			extensions = {},
		})
	end,
}
