-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = '[Q]uit All' })

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move to window using <ctrl> hjkl keys `:help wincmd`
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Go to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Go to upper window' })

-- Buffers
-- stylua: ignore start
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })
vim.keymap.set('n', '<leader>bo', function() Snacks.bufdelete.other() end, { desc = 'Delete Other Buffers' })
-- stylua: ignore end

-- Tabs
-- vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader><tab>l', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>h', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })

-- Windows
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Split windows
vim.keymap.set('n', '<leader>w-', '<c-w>s', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>w|', '<c-w>v', { desc = 'Split Window Right', remap = true })

-- Lazy
-- stylua: ignore start
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Open [L]azy' })
vim.keymap.set("n", '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit (root dir)' })
vim.keymap.set("n", '<leader>fe', function() Snacks.explorer() end, { desc = 'Explorer (cwd)' })
--stylua: ignore end

-- files/find
-- stylua: ignore start
vim.keymap.set('n', '<leader><leader>', function() Snacks.picker.buffers({}) end, { desc = 'Find Buffer' })
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })
vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files({ hidden = true }) end, { desc = 'Find file (cwd)' })
vim.keymap.set('n', '<leader>fr', function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = 'Find Recent Files' })
vim.keymap.set('n', '<leader>f:', function() Snacks.picker.command_history() end, { desc = 'Find Command History' })
-- stylua: ignore end

-- search
-- stylua: ignore start
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end , { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = 'Search Resume' })
-- stylua: ignore end

-- quickfix/diagnostics
local diagnostic_goto = function(next, severity)
  local get_diagnostic = next and vim.diagnostic.get_next or vim.diagnostic.get_prev

  return function()
    vim.diagnostic.jump({
      diagnostic = get_diagnostic({ severity = severity }),
    })
    vim.schedule(function()
      vim.diagnostic.open_float()
    end)
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
