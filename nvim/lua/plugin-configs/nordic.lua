require("nordic").setup {
  telescope = {
    style = "classic",
  },
    -- Enable bold keywords and operators.
    bold_keywords = true,
    -- Enable italicized comments.
    italic_comments = true,
    -- Enable general editor background transparency.
    transparent_bg = false,
    -- Override styling of any highlight group.
    -- (see next section for an example)
    override = {},
    cursorline = {
        bold = false,
        -- Avialable themes: 'dark', 'light'.
        theme = 'light'
    }
}
vim.cmd.colorscheme 'nordic'
