vim.pack.add({
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/folke/sidekick.nvim',
}, { confirm = false })

require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    markdown = true,
    help = true,
  },
})

require('sidekick').setup({
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
    },
  },
  keys = {
    stopinsert = { '<esc><esc>', 'stopinsert', mode = 't' },
  },
})

vim.keymap.set('n', '<tab>', function()
  -- if there is a next edit, jump to it, otherwise apply it if any
  if require('sidekick').nes_jump_or_apply() then
    return -- jumped or applied
  end
  -- if vim.lsp.inline_completion.get() then
  --   return -- nvim native inline completions
  -- end

  -- fallback to normal tab
  return '<Tab>'
end, {
  desc = 'Goto/Apply Next Edit Suggestion',
  expr = true,
})
vim.keymap.set({ 'n', 'v' }, '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle CLI' })
vim.keymap.set({ 'n', 'v' }, '<leader>ad', function() require('sidekick.cli').close() end, { desc = 'Sidekick Detach CLI Session' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Sidekick Select Prompt' })

vim.keymap.set('v', '<leader>as', function() require('sidekick.cli').send({ selection = true }) end, { desc = 'Sidekick Send Visual Selection' })

vim.keymap.set({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send({ msg = '{this}' }) end, { desc = 'Sidekick Send This' })
vim.keymap.set({ 'n' }, '<leader>af', function() require('sidekick.cli').send({ msg = '{file}' }) end, { desc = 'Sidekick Send File' })
vim.keymap.set({ 'x' }, '<leader>av', function() require('sidekick.cli').send({ msg = '{selection}' }) end, { desc = 'Sidekick Send Selection' })

vim.keymap.set({ 'n', 'x', 'i', 't' }, '<c-.>', function() require('sidekick.cli').focus() end, { desc = 'Sidekick Focus' })
