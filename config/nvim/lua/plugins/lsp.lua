return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- general
        "bash",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        -- go
        "go",
        "gomod",
        "gosum",
        "gowork",
        "templ",
        -- web / js
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "tsx",
        "typescript",
        -- python
        "python",
      })
      opts.auto_install = true
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      vim.list_extend(opts.servers, {
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
        -- pyright = {},
        -- ruff_lsp = {},
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
        -- managed by plugin lazyvim.plugins.extras.lang.go
        gopls = {
          -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
          settings = {
            gopls = {
              gofumpt = true,
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
            },
          },
        },
        -- gofumpt = {},
        -- golangci_lint_ls = {},
        templ = {},

        -- web
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = {
          filetypes = { "html", "templ" },
        },
        tailwindcss = {},

        -- flutter/dart
        -- currently managed by flutter-tools
        -- dartls = {},
      })
      vim.list_extend(opts.setup, {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              client.server_capabilities.documentFormattingProvider = true
            end, "yamlls")
          end
        end,
      })

      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })
    end,
  },
}
