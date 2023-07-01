return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  module = true,
  event = { "BufReadPost", "BufNewFile" },
  cmd = {
    "TSInstall",
    "TSInstallInfo",
    "TSUpdate",
    "TSBufEnable",
    "TSBufDisable",
    "TSEnable",
    "TSDisable",
    "TSModuleInfo",
  },
  dependencies = {
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        local indent_blankline = require "indent_blankline"

        indent_blankline.setup {
          show_current_context = true,
          indent_blankline_char = "▏",
          indent_blankline_show_trailing_blankline_indent = false,
          indent_blankline_show_first_indent_level = false,
          indent_blankline_use_treesitter = true,
          indent_blankline_show_current_context = true,
          indent_blankline_buftype_exclude = { "terminal", "nofile" },
          indent_blankline_filetype_exclude = {
            "help",
            "NvimTree",
          },
        }
      end,
    },
  },
  config = function()
    local ts = require("nvim-treesitter.configs")
    local setup = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "gitcommit",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "proto",
        "python",
        "regex",
        "rust",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "css" }, -- list of language that will be disabled
      },
      autopairs = {
        enable = true,
      },
      indent = {
        enable = false,
        disable = {}
      },

    }
    ts.setup(setup)
  end
}
