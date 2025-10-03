-- Status Line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "abeldekat/harpoonline", version = "*" },
	config = function()
		local Harpoonline = require("harpoonline")
		Harpoonline.setup() -- using default config
		-- local lualine_c = { Harpoonline.format, "filename" }
		require("lualine").setup({
			options = {
				icons_enabled = true,
				-- theme = "monokai-pro",
				theme = "gruvbox",
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "NvimTree" },
				always_divide_middle = true,
				color = {},
			},
			sections = {
				lualine_a = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64", bg = "#1a1a1a", gui = "bold" },
					},
					"mode",
				},
				lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
				lualine_c = {
					{
						"filename",
						color = function(section)
							return {
								gui = "bold",
								fg = vim.bo.modified and "#1a1a1a" or "",
								bg = vim.bo.modified and "#fcba03" or "transparent",
							}
						end,
						file_status = true,
						path = 1,
					},
					Harpoonline.format,
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress", "location" },
				lualine_z = {
					"tabs",
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {},
		})
	end,
}
