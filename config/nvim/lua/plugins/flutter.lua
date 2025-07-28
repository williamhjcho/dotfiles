return {
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
      -- {
      --   '<leader>co',
      --   LazyVim.lsp.action['source.organizeImports'],
      --   desc = 'Organize Imports',
      -- },
    },
  },
}
