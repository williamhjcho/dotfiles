return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        '[C]ode [F]ormat',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
        go = { 'gofumpt' },
        javascript = { 'biome' },
        typescript = { 'biome' },
        dart = { 'dart_format' },
        python = { 'ruff_format' },
        toml = { 'taplo' },
        terraform_fmt = { 'terraform' },
        -- yaml = { 'yamlfmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },
}
