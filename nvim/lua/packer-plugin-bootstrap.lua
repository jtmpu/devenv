local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Language server
  -- Mason is used for easy installing LSP servers
  -- null-ls is used for formatting and linting
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim"
  }

  -- Code completion
  -- Hrsh7th Code Completion Suite
  use 'hrsh7th/nvim-cmp'                    -- a completion engine extending lsp's omnifunc
  use 'hrsh7th/cmp-nvim-lsp'                -- cmp source for neovims lsp client
  use 'hrsh7th/cmp-nvim-lua'                -- cmp source for neovim Lua API
  use 'hrsh7th/cmp-nvim-lsp-signature-help' -- cmp source for func signatures emphasis on param
  use 'hrsh7th/cmp-path'                    -- cmp source for fs paths
  use 'hrsh7th/cmp-buffer'                  -- cmp source for buffer words
  -- snippet engine integrated with cmp, cmp requires one or else you
  -- get errors
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- Create and use VSCode snippets, not used atm
  -- use 'hrsh7th/vim-vsnip'
  -- use 'hrsh7th/cmp-vsnip'                   -- cmp source for vsnippets

  -- Colorschemes
  -- use "AlexvZyl/nordic.nvim"
  use 'navarasu/onedark.nvim'

  -- FS tree view
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

  -- Bottom status line and winbar status
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Tabline status
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  -- Treesitter syntax highlighted_strings
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  }

  -- Telescope: Fuzzy finder/picker, for files, symbols anything
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Native fzf for faster performance on telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
