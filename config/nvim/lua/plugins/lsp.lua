return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "python",
        "query",
        "regex",
        "templ",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- general
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        bashls = {},

        -- docker
        dockerls = {},
        docker_compose_language_service = {},

        -- terraform
        terraformls = {},

        -- ansible
        ansiblels = {},

        -- yaml/ toml
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
        taplo = {},

        -- Python
        pyright = {},
        ruff_lsp = {},
        -- ruff_lsp = function()
        --   require("lazyvim.util").lsp.on_attach(function(client, _)
        --     if client.name == "ruff_lsp" then
        --       -- Disable hover in favor of Pyright
        --       client.server_capabilities.hoverProvider = false
        --     end
        --   end)
        -- end,

        -- js/ts
        tsserver = {},
        biome = {},

        -- go
        -- gopls = {
        --   settings = {
        --     gopls = {
        --       gofumpt = true,
        --     },
        --   },
        -- },
        -- gofumpt = {},
        -- golangci_lint_ls = {},
        templ = {},

        -- web
        html = {
          -- filetypes = { 'html', 'templ' },
        },
        htmx = {
          -- filetypes = { 'html', 'templ' },
        },
        tailwindcss = {},

        -- flutter/dart
        -- currently managed by flutter-tools
        -- dartls = {},
      },
      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              client.server_capabilities.documentFormattingProvider = true
            end, "yamlls")
          end
        end,
        -- gopls = function(_, opts)
        --   -- workaround for gopls not supporting semanticTokensProvider
        --   -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        --   LazyVim.lsp.on_attach(function(client, _)
        --     if not client.server_capabilities.semanticTokensProvider then
        --       local semantic = client.config.capabilities.textDocument.semanticTokens
        --       client.server_capabilities.semanticTokensProvider = {
        --         full = true,
        --         legend = {
        --           tokenTypes = semantic.tokenTypes,
        --           tokenModifiers = semantic.tokenModifiers,
        --         },
        --         range = true,
        --       }
        --     end
        --   end, "gopls")
        --   -- end workaround
        -- end,
        -- TODO: setup python
      },
    },

    -- vim.filetype.add({
    --   extension = {
    --     templ = "templ",
    --   },
    -- })
  },
}
