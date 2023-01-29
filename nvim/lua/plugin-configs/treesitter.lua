require("nvim-treesitter.configs").setup {
  -- Parser names to install
  ensure_installed = {
    "go",
    "lua",
    "rust",
    "typescript",
    "html",
    "javascript",
    "css",
    "json",
    "dockerfile",
    "yaml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  },
}
