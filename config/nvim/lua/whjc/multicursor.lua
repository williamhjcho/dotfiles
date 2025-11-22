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
