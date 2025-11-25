-- stylua: ignore
local linters = vim
  .iter(require('whjc.languages'))
  :map(function(i) return i.linters end)
  :filter(function(i) return i end)
  :fold({}, function(acc, linters)
    return vim.tbl_extend('force', acc, linters)
  end)

local lint = require('lint')
lint.linters_by_ft = linters

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('whjc_nvim_lint', { clear = true }),
  callback = function()
    require('lint').try_lint()
  end,
})
