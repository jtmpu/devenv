-- Load plugins
require("packer-plugin-bootstrap")

-- Plugin configurations

-- LSP, Mason, language servers, formatters and linters setup
-- require("plugin-configs.lsp-lua")
require("plugin-configs.lsp")

-- Auto completion setup
require("plugin-configs.hrsh7th-completion")

-- FS tree view
require("plugin-configs.nvim-tree")

-- Lualine
require("plugin-configs.lualine")

-- Bufferline
require("plugin-configs.bufferline")

-- Treesitter syntax highlighting
require("plugin-configs.treesitter")

-- Telescope, fuzzy finder/picker
require("plugin-configs.telescope")

-- Colorthemes
-- require("plugin-configs.nordic")
require("plugin-configs.onedark")

-- User configurations
require("core.utils")
require("core.keymappings")
require("core.settings")
