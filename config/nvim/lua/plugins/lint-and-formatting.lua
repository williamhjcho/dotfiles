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
        python = { "ruff_format" },

        -- managed by the lazyvim.plugins.extras.lang.go
        -- go = { "gofumpt", "goimports" },
        -- BUG: https://github.com/stevearc/conform.nvim/issues/387
        go = {},
        templ = { "templ" },
      },
      formatters = {},
    },
  },
}
