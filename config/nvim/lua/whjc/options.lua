-- See `:help mapleader`
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- See `:help vim.o` or `:help option-list`
vim.opt.autowrite = true -- Enable auto write
vim.opt.breakindent = true -- Enable break indent
-- stylua: ignore
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.colorcolumn = '80,120'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlihgting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.fillchars = { foldopen = '', foldclose = '', fold = ' ', foldsep = ' ', diff = '╱', eob = ' ' }

-- vim.opt.foldenable = true
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
-- vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99

vim.opt.inccommand = 'split' -- Preview substitutions live
vim.opt.laststatus = 3 -- global statusline
vim.opt.mouse = 'a' -- Enable mouse mode
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
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.undofile = true -- Save undo history
vim.opt.undolevels = 10000
--vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.swapfile = false -- Disable swap files
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.winborder = 'rounded' -- set the default border for all floating windows
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

-- relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

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

vim.o.exrc = true
