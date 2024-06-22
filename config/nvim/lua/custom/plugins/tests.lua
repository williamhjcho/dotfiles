return {
  {
    'vim-test/vim-test',
    keys = {
      { '<leader>tt', '<cmd>TestNearest<cr>', desc = '[T]est [T]his' },
      { '<leader>tf', '<cmd>TestFile<cr>', desc = '[T]est [F]ile' },
      { '<leader>ta', '<cmd>TestSuite<cr>', desc = '[T]est Suite' },
      { '<leader>tl', '<cmd>TestLast<cr>', desc = '[T]est [L]ast' },
    },
  },
}
