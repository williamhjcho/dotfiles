-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit All' })
vim.keymap.set('n', '<leader>qR', '<cmd>:restart<cr>', { desc = 'Restart' })

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- vim pack
vim.keymap.set({ 'n', 'x' }, '<leader>pu', function() vim.pack.update() end, { desc = 'Vim Pack Update' })
vim.keymap.set({ 'n', 'x' }, '<leader>pl', function()
  -- stylua: ignore
  local packages = vim
    .iter(vim.pack.get())
    :map(function(p) return {
        active = p.active,
        name = p.spec.name,
        src = p.spec.src,
        rev = p.rev,
    } end)
    :totable()
  print(vim.inspect(packages))
end, { desc = 'Vim Pack List' })
vim.keymap.set({ 'n', 'x' }, '<leader>pd', function()
  -- stylua: ignore
  local inactive = vim
    .iter(vim.pack.get())
    :filter(function(p) return not p.active end)
    :map(function(p) return p.spec.name end)
    :totable()
  if #inactive > 0 then
    print('Deleting inactive plugins: ' .. table.concat(inactive, ', '))
    vim.pack.del(inactive)
  end
end, { desc = 'Vim Pack Delete (inactive)' })
vim.keymap.set({ 'n', 'x' }, '<leader>pD', function()
  local plugins = vim.iter(vim.pack.get()):map(function(p) return p.spec.name end):totable()
  print('Deleting all plugins: ' .. table.concat(plugins, ', '))
  vim.pack.del(plugins)
end, { desc = 'Vim Pack Delete (all)' })

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bd', function() require('snacks').bufdelete() end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })
vim.keymap.set('n', '<leader>bs', function() vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true)) end, { desc = 'Scratch Buffer' })
vim.keymap.set('n', '<leader>bo', function() require('snacks').bufdelete.other() end, { desc = 'Delete Other Buffers' })

-- Tabs
-- vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader><tab>l', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

-- Windows
vim.keymap.set('n', '<leader>wd', '<c-w>c', { desc = 'Delete Window', remap = true })
vim.keymap.set('n', '<leader>w-', '<c-w>s', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>w|', '<c-w>v', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>w>', '10<c-w>>', { desc = 'Increase Window Width' })
vim.keymap.set('n', '<leader>w<', '10<c-w><', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<leader>w+', '10<c-w>+', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<leader>w-', '10<c-w>-', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<leader>w=', '<c-w>=', { desc = 'Equalize Window Sizes' })

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Lsp
vim.keymap.set('n', '<leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Actions' })
vim.keymap.set('n', '<leader>ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Diagnostic popup' })
vim.keymap.set('n', '<leader>lf', '<Cmd>lua require("conform").format()<CR>', { desc = 'Format' })
vim.keymap.set('n', '<leader>li', '<Cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Implementation' })
vim.keymap.set('n', '<leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover' })
vim.keymap.set('n', '<leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
vim.keymap.set('n', '<leader>lR', '<Cmd>lua vim.lsp.buf.references()<CR>', { desc = 'References' })
vim.keymap.set('n', '<leader>ls', '<Cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Source definition' })
vim.keymap.set('n', '<leader>lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Type definition' })

vim.keymap.set('x', '<leader>lf', '<Cmd>lua require("conform").format()<CR>', { desc = 'Format selection' })

vim.keymap.set('n', '<leader>Lr', '<cmd>lsp restart<cr>', { desc = 'Lsp Restart' })
vim.keymap.set('n', '<leader>LR', '<cmd>lsp restart<cr>', { desc = 'Lsp Restart All' })
vim.keymap.set('n', '<leader>Ld', '<cmd>lsp disable<cr>', { desc = 'Lsp Disable' })
vim.keymap.set('n', '<leader>Li', '<cmd>checkhealth vim.lsp<cr>', { desc = 'Lsp Info' })
vim.keymap.set('n', '<leader>gg', function() require('snacks').lazygit() end, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>fe', function() require('snacks').explorer({ hidden = true }) end, { desc = 'Explorer (cwd)' })

-- files/find
vim.keymap.set('n', '<leader><leader>', '<Cmd>Pick buffers<CR>', { desc = 'Find Buffer' })
vim.keymap.set('n', '<leader>f:', '<Cmd>Pick command_history<CR>', { desc = 'Find ":" History' })
vim.keymap.set('n', '<leader>fd', '<Cmd>Pick diagnostic scope="all"<CR>', { desc = 'Diagnostic workspace' })
vim.keymap.set('n', '<leader>fD', '<Cmd>Pick diagnostic scope="current"<CR>', { desc = 'Diagnostic buffer' })
vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find file (cwd)' })
vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Grep live' })
vim.keymap.set('n', '<leader>fG', '<Cmd>Pick grep pattern=<cword><CR>', { desc = 'Grep current word' })
vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fl', '<Cmd>Pick buf_lines scope="all"<CR>', { desc = 'Find lines (all)' })
vim.keymap.set('n', '<leader>fL', '<Cmd>Pick buf_lines scope="current"<CR>', { desc = 'Find lines (current)' })
vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>', { desc = 'Find Resume' })

-- search
vim.keymap.set('n', '<leader>sk', function() require('snacks').picker.keymaps() end, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sg', function() require('snacks').picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sd', function() require('snacks').picker.diagnostics() end, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', function() require('snacks').picker.resume() end, { desc = 'Search Resume' })
vim.keymap.set({ 'n', 'v' }, '<leader>sR', function()
  local grug = require('grug-far')
  local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  })
end, { desc = 'Search and Replace' })

-- quickfix/diagnostics
local diagnostic_goto = function(next, severity)
  local get_diagnostic = next and vim.diagnostic.get_next or vim.diagnostic.get_prev

  return function()
    local diagnostic = get_diagnostic({ severity = severity })
    if not diagnostic then return end

    vim.diagnostic.jump({ diagnostic = diagnostic })
    vim.schedule(function() vim.diagnostic.open_float() end)
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, vim.diagnostic.severity.ERROR), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, vim.diagnostic.severity.ERROR), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, vim.diagnostic.severity.WARN), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, vim.diagnostic.severity.WARN), { desc = 'Prev Warning' })

-- others
vim.keymap.set('n', '<leader>or', '<Cmd>lua MiniMisc.resize_window()<CR>', { desc = 'Resize to default width' })
vim.keymap.set('n', '<leader>oz', '<Cmd>lua MiniMisc.zoom()<CR>', { desc = 'Resize to default width' })

-- persistence
vim.keymap.set('n', '<leader>qs', function() require('persistence').load() end, { desc = 'Restore Session' })
vim.keymap.set('n', '<leader>qS', function() require('persistence').select() end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>ql', function() require('persistence').load({ last = true }) end, { desc = 'Restore Last Session' })
vim.keymap.set('n', '<leader>qd', function() require('persistence').stop() end, { desc = "Don't Save Current Session" })

-- multi cursor
vim.keymap.set({ 'n', 'x' }, '<up>', function() require('multicursor-nvim').lineAddCursor(-1) end)
vim.keymap.set({ 'n', 'x' }, '<down>', function() require('multicursor-nvim').lineAddCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader><up>', function() require('multicursor-nvim').lineSkipCursor(-1) end)
vim.keymap.set({ 'n', 'x' }, '<leader><down>', function() require('multicursor-nvim').lineSkipCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>n', function() require('multicursor-nvim').matchAddCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>s', function() require('multicursor-nvim').matchSkipCursor(1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>N', function() require('multicursor-nvim').matchAddCursor(-1) end)
vim.keymap.set({ 'n', 'x' }, '<leader>S', function() require('multicursor-nvim').matchSkipCursor(-1) end)

-- which key
vim.keymap.set({ 'n', 'x' }, '<leader>?', function() require('which-key').show({ global = false }) end, { desc = 'Buffer Keymaps (which-key}' })
