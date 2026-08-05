local later = Config.later
local add = vim.pack.add

later(function()
  add({
    'https://github.com/zbirenbaum/copilot.lua',
    'https://github.com/folke/sidekick.nvim',
  })

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

  -- sidekick detects running CLI sessions with vim regexes like `\<cursor-agent\>`.
  -- `\<` resolves against the current buffer's 'iskeyword', and the clojure ftplugin adds
  -- `/` to it, so the boundary never matches in `/Users/me/.local/bin/cursor-agent` and
  -- every running session disappears from the picker. Match in a default-'iskeyword' buffer.
  local Tool = require('sidekick.cli.tool')
  local is_proc = Tool.is_proc
  local scratch
  Tool.is_proc = function(self, proc)
    if not (scratch and vim.api.nvim_buf_is_valid(scratch)) then scratch = vim.api.nvim_create_buf(false, true) end
    return vim.api.nvim_buf_call(scratch, function() return is_proc(self, proc) end)
  end

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
end)
