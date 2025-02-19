return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'nvim-java/nvim-java',
    config = false,
    ft = { "java" },
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      {
                        name = "Current Java",
                        path = "~/.sdkman/candidates/java/current",
                      },
                    },
                  },
                },
              },
            },
          },
          setup = {
            jdtls = function()
              require("java").setup({
                root_markers = {
                  "settings.gradle",
                  "settings.gradle.kts",
                  "pom.xml",
                  "build.gradle",
                  "mvnw",
                  "gradlew",
                  "build.gradle",
                  "build.gradle.kts",
                },
              })
            end,
          },
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        automatic_installation = true,
        ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'kotlin_language_server',
          'pyright',
          'gopls',
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
      }
      lspconfig.kotlin_language_server.setup {
        capabilities = capabilities,
      }
      lspconfig.pyright.setup {
        capabilities = capabilities,
      }
      lspconfig.gopls.setup {
        capabilities = capabilities,
      }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
