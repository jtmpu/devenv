-- completeopt is used to manage code suggestions
-- see: https://neovim.io/doc/user/options.html#%27completeopt%27
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions
vim.opt.completeopt =  {"menuone", "noselect", "noinsert", "preview"}
-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- installed autocomplete sources
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'nvim_lsp_signature_help'},
    { name = 'nvim_lua', keyword_length = 2},
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 2 },
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
    -- add formating of the different sources
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
        local menu_icon ={
            nvim_lsp = 'λ',
            vsnip = '⋗',
            buffer = 'b',
            path = 'p'
        }
        item.menu = menu_icon[entry.source.name]
        return item
    end,
  },
})
