return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    -- for lua only
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    opts = {
      closing_tags = { enabled = false },
      decorations = {
        statusline = {
          project_config = true,
          device = true,
        },
      },
    },
    keys = {
      {
        '<leader>Fr',
        '<cmd>FlutterRun<cr>',
        desc = 'Flutter Run',
      },
      {
        '<leader>Fq',
        '<cmd>FlutterQuit<cr>',
        desc = 'Flutter Quit',
      },
      {
        '<leader>FR',
        '<cmd>FlutterRestart<cr>',
        desc = 'Flutter Restart',
      },
      {
        '<leader>Fq',
        '<cmd>FlutterQuit<cr>',
        desc = 'Flutter Quit',
      },
      {
        '<leader>Fl',
        '<cmd>FlutterLogToggle<cr>',
        desc = 'Flutter Log Toggle',
      },
      {
        '<leader>Fdc',
        '<cmd>FlutterCopyProfilesUrl<cr>',
        desc = 'Flutter DevTools Copy URL',
      },
      -- {
      --   '<leader>co',
      --   LazyVim.lsp.action['source.organizeImports'],
      --   desc = 'Organize Imports',
      -- },
    },
  },
}
