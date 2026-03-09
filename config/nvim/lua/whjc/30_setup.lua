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

now(function()
  require('mini.icons').setup({
    file = {
      -- go
      ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      -- web/js/ts
      ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
      ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
      ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
      ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
      ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
    },
    filetype = {
      -- go
      gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    },
  })
end)

-- Better Around/Inside textobjects
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
later(function()
  local ai = require('mini.ai')
  ai.setup({
    n_lines = 500,
    custom_textobjects = {
      o = ai.gen_spec.treesitter({ -- code block
        a = { '@block.outer', '@conditional.outer', '@loop.outer' },
        i = { '@block.inner', '@conditional.inner', '@loop.inner' },
      }),
      f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
      c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
      t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
      d = { '%f[%d]%d+' }, -- digits
      e = { -- Word with case
        { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
        '^().*()$',
      },
      u = ai.gen_spec.function_call(), -- u for "Usage"
      U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
    },
  })
end)

-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
later(
  function()
    require('mini.surround').setup({
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        highlight = 'gsh',
        replace = 'gsr',
      },
    })
  end
)

later(function()
  local statusline = require('mini.statusline')
  statusline.setup({ use_icons = vim.g.have_nerd_font })

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v %p%%' end
end)

later(function()
  require('mini.pairs').setup({
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { 'string' },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  })
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
