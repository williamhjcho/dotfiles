local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
local add = vim.pack.add

now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  require('whjc.lsp')
end)
