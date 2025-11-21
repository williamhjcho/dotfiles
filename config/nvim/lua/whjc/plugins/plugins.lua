return {

  -- better find/replace
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
  },

  { 'b0o/SchemaStore.nvim', version = false },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    --- @module 'snacks'
    --- @type snacks.Config
    opts = {
      indent = { enabled = true },
      lazygit = {},
      explorer = {},
      picker = {},
    },
  },

  -- session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
  },

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
  -- { 'NMAC427/guess-indent.nvim', opts = {} },

  -- better find x replace
  -- {
  --   'MagicDuck/grug-far.nvim',
  --   opts = { headerMaxWidth = 80 },
  -- },

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
    branch = 'main',
    version = false,
    lazy = false,
    build = ':TSUpdate',
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
        -- 'jsonc', -- 403 issue
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
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      ts.setup(opts)

      local to_install = opts.ensure_installed
      local already_installed = ts.get_installed()
      to_install = vim
        .iter(to_install)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()
      if #to_install > 0 then
        ts.install(to_install)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('whjc_treesitter', { clear = true }),
        callback = function(ev)
          if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
            pcall(vim.treesitter.start)
          end
        end,
      })
    end,
  },
}
