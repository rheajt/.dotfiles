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

local function config(filename)
	require(filename)
end

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = config("config.telescope"),
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
		config = config("config.nvim-tree"),
	})

	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = config("config.lualine"),
	})

	-- use("mhartington/formatter.nvim")

	use({
		"terrortylor/nvim-comment",
		config = config("config.nvim-comment"),
	})

	-- Cmp
	use({
		"hrsh7th/nvim-cmp",
		config = config("config.nvim-cmp"),
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
		config = config("config.null-ls"),
	})

	-- Colorscheme
	use("gruvbox-community/gruvbox")
end)
