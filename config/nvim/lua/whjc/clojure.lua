local later = Config.now
local add = vim.pack.add

later(function()
  add({
    'https://github.com/Olical/conjure',
    -- Colorize the output of the log buffer
    'https://github.com/m00qek/baleia.nvim',
  })

  require('conjure.main').main()
  require('conjure.mapping')['on-filetype']()

  -- prefer LSP for jump-to-definition and symbol-doc, and use conjure
  -- alternatives with <localleader>K and <localleader>gd
  vim.g['conjure#mapping#doc_word'] = 'K'
  vim.g['conjure#mapping#def_word'] = 'gd'
  vim.g['conjure#client#clojure#nrepl#mapping#connect_port_file'] = false

  local baleia = require('baleia')
  vim.g.conjure_baleia = baleia.setup({
    line_starts_at = 3,
  })
  vim.api.nvim_create_user_command('BaleiaColorize', function() vim.g.conjure_baleia.once(vim.api.nvim_get_current_buf()) end, { bang = true })
  vim.api.nvim_create_user_command('BaleiaLogs', vim.g.conjure_baleia.logger.show, { bang = true })
end)
