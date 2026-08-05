vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- See `:help vim.o` or `:help option-list`
vim.opt.autoread = true -- update file when changed outside of vim
vim.opt.breakindent = true -- Enable break indent
vim.opt.cmdheight = 0
vim.opt.colorcolumn = '80,120'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlihgting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.exrc = true
vim.opt.fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' }
vim.opt.ignorecase = true
vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.laststatus = 3 -- global statusline
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false -- Disable default ruler
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = 'yes:1' -- Always show the sign column (to avoid shifts)
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Inserts indents automatically
vim.opt.spelllang = { 'en' }
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.swapfile = false -- Disable swap files
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.softtabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300
vim.opt.undofile = true -- Save undo history
vim.opt.undolevels = 10000
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.winborder = 'rounded' -- set the default border for all floating windows
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- folding
-- vim.opt.foldenable = true
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
-- vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99

vim.filetype.add({
  extension = {
    env = 'dotenv',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['env'] = 'dotenv',
  },
  pattern = {
    ['%.env%.[%w_.-]+'] = 'dotenv',
  },
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- underline = {
  --   severity = {
  --     min = vim.diagnostic.severity.HINT,
  --     max = vim.diagnostic.severity.ERROR,
  --   },
  -- },
  -- don't update diagnostics when typing
  update_in_insert = false,
  virtual_text = true,
})
