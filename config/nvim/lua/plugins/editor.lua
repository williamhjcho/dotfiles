return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- storm, moon, night, day
      style = 'moon',
      on_colors = function(colors)
        -- makes comments a little brighter so its easier to see
        colors.comment = '#7c86bf'
      end,
      on_highlights = function(hl, c)
        hl.LineNr.fg = c.comment
        hl.LineNrAbove.fg = c.comment
        hl.LineNrBelow.fg = c.comment
        -- hl.CursorLineNr.fg = "#00FF00"
        -- gl.DiagnosticUnnecessary = { fg = commentColor }
      end,
    },
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      -- wave, dragon, lotus
      theme = 'wave',
    },
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    opts = {
      style = 'cool',
    },
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    --- @module 'snacks'
    --- @type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          -- pick = function(cmd, opts)
          --   return LazyVim.pick(cmd, opts)()
          -- end,
          header = [[
        ╔══════════════════════════════════════╗
        ║  ██╗    ██╗██╗  ██╗     ██╗ ██████╗  ║
        ║  ██║    ██║██║  ██║     ██║██╔════╝  ║
        ║  ██║ █╗ ██║███████║     ██║██║       ║
        ║  ██║███╗██║██╔══██║██   ██║██║       ║
        ║  ╚███╔███╔╝██║  ██║╚█████╔╝╚██████╗  ║
        ║   ╚══╝╚══╝ ╚═╝  ╚═╝ ╚════╝  ╚═════╝  ║
        ╚══════════════════════════════════════╝
 ]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
      indent = { enabled = true },
      lazygit = {},
      explorer = {},
      picker = {},
    },
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = LazyVim.config.icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        --   return vim.trim(ret)
        -- end,
        offsets = {
          { filetype = 'snacks_layout_box' },
        },
        ---@param opts bufferline.IconFetcherOpts
        -- get_element_icon = function(opts)
        --   return LazyVim.config.icons.ft[opts.filetype]
        -- end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        desc = 'Restore Session',
      },
      {
        '<leader>qS',
        function()
          require('persistence').select()
        end,
        desc = 'Select Session',
      },
      {
        '<leader>ql',
        function()
          require('persistence').load({ last = true })
        end,
        desc = 'Restore Last Session',
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },

  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },

  { 'j-hui/fidget.nvim', opts = {} },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      defaults = {},
      spec = {
        { '<leader><tab>', group = 'tabs' },
        { '<leader>b', group = 'buffer' },
        { '<leader>c', group = 'code' },
        { '<leader>d', group = 'debug' },
        { '<leader>f', group = 'file|find' },
        { '<leader>q', group = 'quit|session' },
        { '<leader>s', group = 'search' },
        { '<leader>x', group = 'diagnostics|quickfix' },
        { 'g', group = 'goto' },
        { 'gs', group = 'surround' },
        { 'z', group = 'fold' },
      },
    },
    keys = {
      {
        '<Leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        { desc = 'Buffer Keymaps (which-key)' },
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Detect tabstop and shiftwidth automatically
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- better find x replace
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require('grug-far')
          local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  },

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

      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v %p%%'
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    version = false,
    -- Sets main module to use for opts
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        -- general
        'bash',
        'diff',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'toml',
        'xml',
        'yaml',
        'json',
        'jsonc',
        'json5',
        -- git
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        -- lua/vim/nvim
        'lua',
        'luap',
        'luadoc',
        'vim',
        'vimdoc',
        -- terraform
        'terraform',
        'hcl',
        -- web/js/ts
        'html',
        'css',
        'jsdoc',
        'tsx',
        'typescript',
        'astro',
        'svelte',
        -- go
        'go',
        'gomod',
        'gowork',
        'gosum',
        -- python
        'python',
        -- dart/flutter
        'dart',
        -- clojure
        'clojure',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },

  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'jake-stewart/multicursor.nvim',
    config = function()
      local mc = require('multicursor-nvim')
      mc.setup()

      -- stylua: ignore start
      vim.keymap.set({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end)
      vim.keymap.set({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end)
      vim.keymap.set({ 'n', 'x' }, '<leader><up>', function() mc.lineSkipCursor(-1) end)
      vim.keymap.set({ 'n', 'x' }, '<leader><down>', function() mc.lineSkipCursor(1) end)

      vim.keymap.set({ 'n', 'x' }, '<leader>n', function() mc.matchAddCursor(1) end)
      vim.keymap.set({ 'n', 'x' }, '<leader>N', function() mc.matchAddCursor(-1) end)
      -- stylua: ignore end

      --- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)
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
    end,
  },
}
