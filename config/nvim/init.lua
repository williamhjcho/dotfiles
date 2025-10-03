require('options')

vim.pack.add({
  -- colorschemes
  { src = 'https://github.com/navarasu/onedark.nvim' },
  -- { src = 'https://github.com/rebelot/kanagawa.nvim' },
  -- { src = 'https://github.com/folke/tokyonight.nvim' },

  -- editor plugins
  { src = 'https://github.com/chrisgrieser/nvim-origami' },
  { src = 'https://github.com/jake-stewart/multicursor.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' }, -- Detect tabstop and shiftwidth automatically

  -- lsp related
  { src = 'https://github.com/b0o/SchemaStore.nvim' },
  { src = 'https://github.com/MagicDuck/grug-far.nvim' }, -- better find/replace
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
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

require('colorschemes')

require('origami').setup({
  autoFold = { enabled = false },
})

local multicursor = require('multicursor-nvim')
multicursor.setup()
-- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
multicursor.addKeymapLayer(function(layerSet)
  -- Select a different cursor as the main one.
  layerSet({ 'n', 'x' }, '<left>', multicursor.prevCursor)
  layerSet({ 'n', 'x' }, '<right>', multicursor.nextCursor)

  -- Delete the current cursor.
  layerSet({ 'n', 'x' }, '<leader>x', multicursor.deleteCursor)

  -- Enable and clear cursors using escape.
  layerSet('n', '<esc>', function()
    if not multicursor.cursorsEnabled() then
      multicursor.enableCursors()
    else
      multicursor.clearCursors()
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

require('keymaps')

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  callback = function()
    vim.hl.on_yank()
  end,
})

require('autocmds')
require('lazy-init')

-- requires packages to already be present
require('lsp')
