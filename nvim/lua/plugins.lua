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
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("config.telescope")
		end,
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("elianiva/telescope-npm.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.treesitter")
		end,
	})

	--Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	-- use("jose-elias-alvarez/nvim-lsp-ts-utils")

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
		config = function()
			require("config.lualine")
		end,
	})

	-- Nvim Comment
	use({
		"terrortylor/nvim-comment",
		config = function()
			require("config.nvim-comment")
		end,
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		requires = {
			"rafamadriz/friendly-snippets",
		},
		-- config = function()
		-- 	require("snippets")
		-- end,
	})

	-- Cmp
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("config.nvim-cmp")
		end,
	})
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	use({ "saadparwaiz1/cmp_luasnip" })

	-- Null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("config.null-ls")
		end,
	})

	-- Trouble
	use({
		"folke/trouble.nvim",
		config = function()
			require("config.trouble")
		end,
	})

	-- git signs
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Colorscheme
	use("rafamadriz/themes.nvim")
	use("rebelot/kanagawa.nvim")
end)
