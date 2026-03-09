vim.pack.add({
  'https://github.com/nvim-flutter/flutter-tools.nvim',

  -- dependencies
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/stevearc/dressing.nvim',
}, { confirm = false })

require('flutter-tools').setup({
  closing_tags = { enabled = false },
  decorations = {
    statusline = {
      project_config = true,
      device = true,
    },
  },
  debugger = {
    enabled = true,
  },
  dev_tools = {
    autostart = true,
    auto_open_browser = false,
  },
})

vim.keymap.set('n', '<leader>Fr', '<cmd>FlutterRun<cr>', { desc = 'Flutter Run' })
vim.keymap.set('n', '<leader>Fd', '<cmd>FlutterDevices<cr>', { desc = 'Flutter Devices' })
vim.keymap.set('n', '<leader>Fq', '<cmd>FlutterQuit<cr>', { desc = 'Flutter Quit' })
vim.keymap.set('n', '<leader>FR', '<cmd>FlutterRestart<cr>', { desc = 'Flutter Restart' })
vim.keymap.set('n', '<leader>Fq', '<cmd>FlutterQuit<cr>', { desc = 'Flutter Quit' })
vim.keymap.set('n', '<leader>Fll', '<cmd>FlutterLogToggle<cr>', { desc = 'Flutter Log Toggle' })
vim.keymap.set('n', '<leader>Flx', '<cmd>FlutterLogClear<cr>', { desc = 'Flutter Log Clear' })
vim.keymap.set('n', '<leader>Fo', '<cmd>FlutterOpenDevTools<cr>', { desc = 'Flutter DevTools Open' })
vim.keymap.set('n', '<leader>Fy', '<cmd>FlutterCopyProfilesUrl<cr>', { desc = 'Flutter DevTools Copy URL' })
