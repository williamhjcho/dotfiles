local lint = require('lint')
lint.linters_by_ft = {
  --   sh = { 'shellcheck' },
  --   zsh = { 'zsh' },
  dockerfile = { 'hadolint' },
  typescript = { 'biomejs' },
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('whjc_nvim_lint', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})
