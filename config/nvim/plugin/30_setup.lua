local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

now(function()
  vim.pack.add({
    -- 'https://github.com/navarasu/onedark.nvim',
    -- 'https://github.com/folke/tokyonight.nvim',
    'https://github.com/serhez/teide.nvim',
    -- 'https://github.com/rebelot/kanagawa.nvim',
  })

  require('teide').setup({
    style = 'dimmed', -- darker, dark, dimmed, light
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
  vim.cmd('colorscheme teide')
end)

later(function() require('mini.extra').setup() end)

later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),
      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)
