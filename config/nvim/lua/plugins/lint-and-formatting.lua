return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        zsh = { "zsh" },
        python = { "ruff" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
        typescript = { "biomejs" },
        go = { "golangcilint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        dart = { "dart_format" },
        lua = { "stylua" },
        sh = { "shfmt" },
        terraform_fmt = { "terraform" },
        toml = { "taplo" },
        javascript = { "biome" },
        typescript = { "biome" },

        -- managed by the lazyvim.plugins.extras.lang.go
        -- go = { "gofumpt", "goimports" },
        --
        -- managed by the lazyvim.plugins.extras.lang.python
        -- python = { "ruff_format" },
      },
      formatters = {
        -- BUG: https://github.com/stevearc/conform.nvim/issues/387
        gofumpt = {
          args = { "$FILENAME" },
        },
      },
    },
  },
}
