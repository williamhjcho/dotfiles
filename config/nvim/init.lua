require('options')

vim.pack.add({
  { src = 'https://github.com/navarasu/onedark.nvim' },
  -- { src = 'https://github.com/rebelot/kanagawa.nvim' },
  --
  { src = 'https://github.com/folke/tokyonight.nvim' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/chrisgrieser/nvim-origami' },

  { src = 'https://github.com/christoomey/vim-tmux-navigator' }, -- TODO: fix tmux load/setup
  { src = 'https://github.com/jake-stewart/multicursor.nvim' },
  { src = 'https://github.com/b0o/SchemaStore.nvim' },
  -- Detect tabstop and shiftwidth automatically
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  -- better find/replace
  { src = 'https://github.com/MagicDuck/grug-far.nvim' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  -- { src = 'https://github.com/folke/ts-comments.nvim' }, -- TODO: not working with pack
})

local debug = false

local pack_plugins = vim.pack.get()
if debug then
  print(vim
    .iter(pack_plugins)
    :map(function(plugin)
      return string.format('%s (%s): %s', plugin.spec.name, tostring(plugin.active), plugin.path)
    end)
    :join('\n'))
end

local to_delete = vim
  .iter(pack_plugins)
  :filter(function(plugin)
    return not plugin.active
  end)
  :map(function(plugin)
    return plugin.spec.name
  end)
  :totable()
if #to_delete > 0 then
  if debug then
    print(string.format('Deleting packages (%d): %s', #to_delete, table.concat(to_delete, ', ')))
  end
  vim.pack.del(to_delete)
end

require('onedark').setup({ style = 'cool' })
-- require('tokyonight').setup({
--   -- storm, moon, night, day
--   style = 'moon',
--   on_colors = function(colors)
--     -- makes comments a little brighter so its easier to see
--     colors.comment = '#7c86bf'
--   end,
--   on_highlights = function(hl, c)
--     hl.LineNr.fg = c.comment
--     hl.LineNrAbove.fg = c.comment
--     hl.LineNrBelow.fg = c.comment
--     -- hl.CursorLineNr.fg = "#00FF00"
--     -- gl.DiagnosticUnnecessary = { fg = commentColor }
--   end,
-- })
-- require('kanagawa').setup({
--   -- wave, dragon, lotus
--   theme = 'wave',
-- })

vim.cmd.colorscheme('onedark')

require('origami').setup({
  autoFold = { enabled = false },
})

local multicursor = require('multicursor-nvim')
multicursor.setup()

--- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
multicursor.addKeymapLayer(function(layerSet)
  -- Select a different cursor as the main one.
  layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
  layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

  -- Delete the main cursor.
  layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

  -- Enable and clear cursors using escape.
  layerSet('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

-- stylua: ignore start
vim.keymap.set({ 'n', 'x' }, '<up>', function() multicursor.lineAddCursor(-1) end)
vim.keymap.set({ 'n', 'x' }, '<down>', function() multicursor.lineAddCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader><up>', function() multicursor.lineSkipCursor(-1) end)
vim.keymap.set({ 'n', 'x' }, '<leader><down>', function() multicursor.lineSkipCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>n', function() multicursor.matchAddCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>N', function() multicursor.matchAddCursor(-1) end)
-- stylua: ignore end

require('guess-indent').setup({})
require('grug-far').setup({ headerMaxWidth = 80 })
require('nvim-ts-autotag').setup({})
-- require('ts-comments').setup({})

-- TODO: do something
-- FIXME: fix something
require('keymaps')

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- require('autocmds')
require('lazy-init')

-- requires packages to already be present
require('lsp')
