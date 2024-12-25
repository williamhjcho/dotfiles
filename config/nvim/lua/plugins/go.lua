return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        -- go
        "go",
        "gomod",
        "gosum",
        "gowork",
        "templ",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "goimports",
        "gofumpt",
        "delve",
        "gomodifytags",
        "impl",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = false,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, "gopls")
          -- end workaround
        end,
      },
    },
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     opts.inlay_hints = { enabled = false }
  --
  --     vim.list_extend(opts.servers, {
  --       -- managed by plugin lazyvim.plugins.extras.lang.go
  --       gopls = {
  --         -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  --         settings = {
  --           gopls = {
  --             gofumpt = true,
  --             analyses = {
  --               fieldalignment = true,
  --               nilness = true,
  --               unusedparams = true,
  --               unusedwrite = true,
  --               useany = true,
  --             },
  --           },
  --         },
  --       },
  --       -- gofumpt = {},
  --       -- golangci_lint_ls = {},
  --       templ = {},
  --     })
  --     vim.filetype.add({
  --       extension = {
  --         templ = "templ",
  --       },
  --     })
  --   end,
  -- },
  {
    "fredrikaverpil/neotest-golang",
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- managed by the lazyvim.plugins.extras.lang.go
        -- go = { "gofumpt", "goimports" },
        -- BUG: https://github.com/stevearc/conform.nvim/issues/387
        go = { "goimports", "gofumpt" },
        templ = { "templ" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
}
