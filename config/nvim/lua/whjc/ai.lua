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
      enabled = false,
    },
  },
  keys = {
    stopinsert = { '<esc><esc>', 'stopinsert', mode = 't' },
  },
})


-- stylua: ignore start
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
vim.keymap.set({ 'n', 'v' }, '<leader>aa', function() require('sidekick.cli').toggle({ name = 'claude' }) end, { desc = 'Sidekick Toggle CLI' })

vim.keymap.set('v', '<leader>as', function() require('sidekick.cli').send({ selection = true }) end, { desc = 'Sidekick Send Visual Selection' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Sidekick Select Prompt', })
vim.keymap.set({ 'n', 'x', 'i', 't' }, '<c-.>', function() require('sidekick.cli').focus() end, { desc = 'Sidekick Switch Focus' })
-- stylua: ignore end
