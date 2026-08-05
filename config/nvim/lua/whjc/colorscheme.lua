local now = Config.now
local add = vim.pack.add

now(function()
  add({ 'https://github.com/serhez/teide.nvim' })

  vim.cmd.colorscheme('teide-dark')
end)
