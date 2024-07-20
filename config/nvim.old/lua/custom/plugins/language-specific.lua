return {
  -- Flutter
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('flutter-tools').setup {
        closing_tags = { enabled = false },
        decorations = {
          statusline = {
            project_config = true,
            device = true,
          },
        },
      }
      require('telescope').load_extension 'flutter'
    end,
    keys = {
      {
        '<leader>Fl',
        '<cmd>Telescope flutter commands<cr>',
        desc = 'Flutter Commands',
      },
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
        '<leader>Fdc',
        '<cmd>FlutterCopyProfilesUrl<cr>',
        desc = 'Flutter DevTools Copy URL',
      },
    },
  },
  -- Python
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap-python',
    },
    branch = 'regexp',
    opts = {
      -- Your options go here
      -- name = "venv",
      auto_refresh = true,
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>pvs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      -- { '<leader>pvc', '<cmd>VenvSelectCached<cr>' },
    },
  },
}
