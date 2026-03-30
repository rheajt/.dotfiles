vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
		lualine_c = {
			{
				"filename",
				color = function()
					return {
						gui = "bold",
						fg = vim.bo.modified and "#1a1a1a" or nil,
						bg = vim.bo.modified and "#fcba03" or nil,
					}
				end,
				file_status = true,
				path = 1,
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress", "location" },
		lualine_z = {
			"tabs",
		},
	},
})

-- require("lualine").setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = "catppuccin",
-- 		component_separators = { left = "", right = "" },
-- 		section_separators = { left = "", right = "" },
-- 		disabled_filetypes = { "NvimTree" },
-- 		always_divide_middle = true,
-- 	},
-- 	tabline = {},
-- 	winbar = {},
-- 	inactive_winbar = {},
-- 	sections = {
-- 		lualine_a = {
-- 			-- {
-- 			-- 	require("noice").api.statusline.mode.get,
-- 			-- 	cond = require("noice").api.statusline.mode.has,
-- 			-- 	color = { fg = "#ff9e64", bg = "#1a1a1a", gui = "bold" },
-- 			-- },
-- 			"mode",
-- 		},
-- 		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
-- 		lualine_c = {
-- 			{
-- 				"filename",
-- 				color = function()
-- 					return {
-- 						gui = "bold",
-- 						fg = vim.bo.modified and "#1a1a1a" or "",
-- 						bg = vim.bo.modified and "#fcba03" or "transparent",
-- 					}
-- 				end,
-- 				file_status = true,
-- 				path = 1,
-- 			},
-- 			-- Harpoonline.format,
-- 		},
-- 		lualine_x = { "encoding", "fileformat", "filetype" },
-- 		lualine_y = { "progress", "location" },
-- 		lualine_z = {
-- 			"tabs",
-- 		},
-- 	},
-- 	inactive_sections = {
-- 		lualine_a = {},
-- 		lualine_b = {},
-- 		lualine_c = {},
-- 		lualine_x = {},
-- 		lualine_y = {},
-- 		lualine_z = {},
-- 	},
-- 	extensions = {},
-- })
