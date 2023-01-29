local fn = vim.fn
local opt = vim.opt

-- opt.mouse = "a"
opt.shell = "/bin/bash"

-- NVim UI
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.ruler = true
opt.number = true
opt.cursorline = false
opt.showtabline = 2
opt.cmdheight = 2
opt.pumheight = 10
opt.showmatch = true
opt.ignorecase = true -- ignore case letters in search
opt.smartcase = true  -- ignore lowercase for whole pattern
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes"

-- Settings
opt.hidden = true
opt.history = 100

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
