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
	-- package_root = require("packer.util").join_paths(vim.fn.stdpath "data", "lvim", "pack"),
	git = { clone_timeout = 300 },
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("kyazdani42/nvim-web-devicons")

	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvimtree")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("line")
		end,
	})

	use("mhartington/formatter.nvim")

	use({
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup({
				comment_empty = false,
			})
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("tscope")
		end,
	})

	use("elianiva/telescope-npm.nvim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")

	-- Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("completer")
		end,
	})
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

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")

	-- Colorscheme
	use("gruvbox-community/gruvbox")
end)
