return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
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
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
