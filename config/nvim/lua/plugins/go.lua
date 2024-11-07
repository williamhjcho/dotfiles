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
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      vim.list_extend(opts.servers, {
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
      })
      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })
    end,
  },
}
