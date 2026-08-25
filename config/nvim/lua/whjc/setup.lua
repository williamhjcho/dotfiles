local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

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

now_if_args(function()
  require('mini.misc').setup()

  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
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

-- Picker for selecting files, grep, etc
-- <C-n> / <Down> moves down; <C-p> / <Up> moves up.
-- <Left> / <Right> moves prompt caret left / right.
-- <S-Tab> toggles information window with all available mappings.
-- <Tab> toggles preview.
-- <C-x> / <C-a> toggles current / all item(s) as (un)marked.
-- <C-Space> / <M-Space> makes all matches or marked items as new picker.
-- <CR> / <M-CR> chooses current/marked item(s).
-- <Esc> / <C-c> stops picker.
later(function() require('mini.pick').setup() end)

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
  local default_section_mode = statusline.section_mode

  local function visual_selection()
    local mode = vim.fn.mode()
    if mode == 'V' or mode == 'S' then
      local lines = math.abs(vim.fn.line('.') - vim.fn.line('v')) + 1
      return string.format('%d line(s)', lines)
    end

    if mode == 'v' or mode == 's' or mode == '\22' or mode == '\23' then
      local chars = vim.fn.wordcount().visual_chars
      return string.format('%d char(s)', chars)
    end
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_mode = function(args)
    local mode, mode_hl = default_section_mode(args)
    local recording = vim.fn.reg_recording()
    if recording ~= '' then
      mode = string.format('%s @%s', mode, recording)
    end
    local executing = vim.fn.reg_executing()
    if executing ~= '' then
      mode = string.format('%s @%s', mode, executing)
    end
    return mode, mode_hl
  end

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function(args)
    local selection = visual_selection()
    local location = MiniStatusline.is_truncated(args.trunc_width) and '%2l:%-2v' or '%2l:%-2v %p%%'
    if selection == nil then return location end
    return selection .. ' · ' .. location
  end

  statusline.setup({ use_icons = vim.g.have_nerd_font })

  local macro_group = vim.api.nvim_create_augroup('whjc_statusline_macro', { clear = true })
  vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
    group = macro_group,
    callback = function() vim.cmd('redrawstatus') end,
    desc = 'Refresh statusline when macro recording starts or stops',
  })
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
