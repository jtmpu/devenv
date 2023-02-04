return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  module = true,
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    config = function()
        local icons = require "nvim-web-devicons"
        icons.set_icon {
          deb = { icon = "", name = "Deb", color = "#a1b7ee" },
          lock = { icon = "", name = "Lock", color = "#c4c720" },
          mp3 = { icon = "", name = "Mp3", color = "#d39ede" },
          mp4 = { icon = "", name = "Mp4", color = "#9ea3de" },
          out = { icon = "", name = "Out", color = "#abb2bf" },
          ["robots.txt"] = { icon = "ﮧ", name = "Robots", "#abb2bf" },
          ttf = { icon = "", name = "TrueTypeFont", "#abb2bf" },
          rpm = { icon = "", name = "Rpm", "#fca2aa" },
          woff = { icon = "", name = "WebOpenFontFormat", color = "#abb2bf" },
          woff2 = { icon = "", name = "WebOpenFontFormat2", color = "#abb2bf" },
          xz = { icon = "", name = "Xz", color = "#519aba" },
          zip = { icon = "", name = "Zip", color = "#f9d71c" },
          snippets = { icon = "", name = "Snippets", color = "#51afef" },
          ahk = { icon = "", name = "AutoHotkey", color = "#51afef" },
      }
      end,
  },
  config = function()
    local tree = require("nvim-tree")
    local setup = {
    }
    tree.setup(setup)
  end,
}
