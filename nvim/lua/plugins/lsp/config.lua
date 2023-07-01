local M = {}
local keymap = vim.keymap.set

M.setup = function()
  local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local config = {
    -- Enable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local bufopts = { buffer = bufnr, silent = true }
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "gr", vim.lsp.buf.references, bufopts)
end


-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

local function disable_format_on_save()
  vim.api.nvim_del_augroup_by_name "Format on save"
  vim.notify("Format on save is now disabled", vim.log.levels.INFO)
end

local function enable_format_on_save(client)
  vim.api.nvim_create_augroup("Format on save", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
      vim.lsp.buf.format {
        filter = function()
          if client.supports_method "textDocument/formatting" then
            return client.name ~= "null-ls"
          else
            return "null-ls"
          end
        end,
      }
    end,
    group = "Format on save",
  })
  vim.notify("Format on save is now enabled", vim.log.levels.INFO)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight(client, bufnr)

  if vim.fn.exists "#Format on save#BufWritePre" == 0 then
    enable_format_on_save(client)
  end

  vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
    if vim.fn.exists "#Format on save#BufWritePre" == 0 then
      enable_format_on_save(client)
    else
      disable_format_on_save()
    end
  end, { nargs = "*" })
  client.server_capabilities.semanticTokensProvider = nil
end

M.flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local cmp = require("cmp_nvim_lsp")
M.capabilities = cmp.default_capabilities()

return M
