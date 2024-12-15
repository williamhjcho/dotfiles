return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        zsh = { "zsh" },
        python = { "ruff" },
        dockerfile = { "hadolint" },
        typescript = { "biomejs" },
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
        zsh = { "beautysh" },
        terraform_fmt = { "terraform" },
        toml = { "taplo" },
        javascript = { "biome" },
        typescript = { "biome" },
        python = { "ruff_format" },
      },
      formatters = {},
    },
  },
}
