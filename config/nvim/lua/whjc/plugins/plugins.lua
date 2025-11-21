return {
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
