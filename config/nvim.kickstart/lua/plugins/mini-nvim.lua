return {
  -- Collection of various small independent plugins/modules
  -- https://github.com/echasnovski/mini.nvim
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup({
        mappings = {
          add = 'gsa',
          delete = 'gsd',
          find = 'gsf',
          highlight = 'gsh',
          replace = 'gsr',
        },
      })

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

      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v %p%%'
      end
    end,
  },
}
