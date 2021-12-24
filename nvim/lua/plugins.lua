local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

packer.init({
	git = { clone_timeout = 300 },
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	})

	-- Telescope extensions
	use("elianiva/telescope-npm.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- Tree
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("config.nvim-tree")
		end,
	})

	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		--config = config("config.lualine"),
		config = function()
			require("config.lualine")
		end,
	})

	-- TODO: remove buffer line
	-- use({
	-- 	"akinsho/bufferline.nvim",
	-- 	requires = "kyazdani42/nvim-web-devicons",
	-- 	config = function()
	-- 		require("bufferline").setup({
	-- 			options = {
	-- 				numbers = "ordinal",
	-- 				diagnostics = "nvim_lsp",
	-- 				offsets = {
	-- 					{
	-- 						filetype = "NvimTree",
	-- 						text = function()
	-- 							return vim.fn.getcwd()
	-- 						end,
	-- 						highlight = "Directory",
	-- 						text_align = "left",
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- })

	-- use("mhartington/formatter.nvim")

	use({
		"terrortylor/nvim-comment",
		--config = config("config.nvim-comment"),
		config = function()
			require("config.nvim-comment")
		end,
	})

	-- Cmp
	use({
		"hrsh7th/nvim-cmp",
		--config = config("config.nvim-cmp"),
		config = function()
			require("config.nvim-cmp")
		end,
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		config = function()
			require("snippets")
		end,
	})

	use("rafamadriz/friendly-snippets")

	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("onsails/lspkind-nvim")

	-- Null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		--config = config("config.null-ls"),
		config = function()
			require("config.null-ls")
		end,
	})

	-- Trouble
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Colorscheme
	use("rafamadriz/themes.nvim")
	use("rebelot/kanagawa.nvim")
end)
