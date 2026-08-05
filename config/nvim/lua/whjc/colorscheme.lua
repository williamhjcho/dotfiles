local now = Config.now
local add = vim.pack.add

now(function()
  add({
    -- 'https://github.com/navarasu/onedark.nvim',
    -- 'https://github.com/folke/tokyonight.nvim',
    'https://github.com/serhez/teide.nvim',
    -- 'https://github.com/rebelot/kanagawa.nvim',
  })

  require('teide').setup({
    style = 'dark', -- darker, dark, dimmed, light
  })
  -- require('onedark').setup({ style = 'cool' })
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
  vim.cmd.colorscheme('teide')
end)
