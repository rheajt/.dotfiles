require("plugins")
require("settings")
require("keymaps")
require("lsp-startup")

--TODO break into separate file
require("formatter").setup({
	filetype = {
		typescriptreact = {
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		typescript = {
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		javascriptreact = {
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		javascript = {
			function()
				return {
					exe = "prettierd",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						--   "--config-path "
						--     .. os.getenv("XDG_CONFIG_HOME")
						--     .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},
})
