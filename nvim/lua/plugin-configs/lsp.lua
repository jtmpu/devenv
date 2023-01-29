--[[
Configure LSP and mason to automatically download, install and configure language
servers, linters, formatters for the languages
]]
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
-- Define which what should be installed
require("mason-lspconfig").setup {
    ensure_installed = {
      "sumneko_lua",
      "rust_analyzer",
      "gopls",
    },
}

-- Define shared keybinds and settings across languages
local lspconf = {}
lspconf.buf_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
lspconf.lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
lspconf.capabilities = require("cmp_nvim_lsp").default_capabilities()


-- Lua LSP config
require("lspconfig")["sumneko_lua"].setup{
    on_attach = lspconf.buf_on_attach,
    capabilities = lspconf.capabilities,
    flags = lspconf.lsp_flags,
    settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Rust LSP config
require("lspconfig").rust_analyzer.setup{
  on_attach = lspconf.buf_on_attach,
  capabilities = lspconf.capabilities,
  flags = lspconf.lsp_flags,
}

-- Rust LSP config
require("lspconfig").gopls.setup{
  on_attach = lspconf.buf_on_attach,
  capabilities = lspconf.capabilities,
  flags = lspconf.lsp_flags,
}


-- Linting and formatting setup
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.gofumpt,
  }
})

