local fn = vim.fn
local opt = vim.opt

-- NVim UI
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.ignorecase = true -- ignore case letters in search
opt.smartcase = true  -- ignore lowercase for whole pattern

-- Tabs, indents
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.autoindent = true

-- Other
opt.updatetime = 300
opt.timeoutlen = 500
opt.undodir = fn.expand("$HOME") .. "/.vimdid"
opt.undofile = true
opt.termguicolors = true

-- Color configs
vim.opt.termguicolors = true

-- Disable netrw (from nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
