return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      }, -- Package Manager
      dependencies = "williamboman/mason-lspconfig.nvim",
      config = function()

      end,
    },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconf = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local lspopts = require("plugins.lsp.config")

    local servers = {
      "sumneko_lua",
    }

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    mason_lspconf.setup({
      ensure_installed = servers,
    })

    -- Configure diagnostics and other LSP options
    lspopts.setup()

    mason_lspconf.setup_handlers({
      function(server_name)
        local opts = {
          on_attach = lspopts.on_attach,
          flags = lspopts.flags,
          capabilities = lspopts.capabilities,
        }

        local require_ok, server = pcall(require, "plugins.lsp.settings." .. server_name)
        if require_ok then
          opts = vim.tbl_deep_extend("force", server, opts)
        end

        lspconfig[server_name].setup(opts)
      end,
    })

  end,
}

