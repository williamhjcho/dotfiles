if not vim.g.vscode then
  return
end

local vscode = require("vscode")
local keymap = vim.keymap.set

keymap("n", "<Space>", "", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- file/tab/window management
keymap("n", "<leader>bd", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>", { desc = "Close buffer/file" })
keymap("n", "<leader>t", "<cmd>lua require('vscode').notify('something happening!')<CR>")

keymap("n", "<leader>w-", "<c-w>s", { desc = "Split Window Below", remap = true })
keymap("n", "<leader>w|", "<c-w>v", { desc = "Split Window Right", remap = true })

keymap("n", "<s-l>", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
keymap("n", "<s-h>", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })

keymap("n", "<c-h>", "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>")
keymap("n", "<c-l>", "<cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>")
keymap("n", "<c-k>", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>")
keymap("n", "<c-j>", "<cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>")

keymap("n", "<s-l>", "<cmd>lua require('vscode').action('workbench.action.nextEditor')<CR>")
keymap("n", "<s-h>", "<cmd>lua require('vscode').action('workbench.action.previousEditor')<CR>")

keymap("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", { desc = "Find File" })
keymap("n", "<leader>sg", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", { desc = "Find in Files" })

keymap("n", "<leader>fe", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>", { desc = "Open File Explorer" })

-- better indent handling
keymap("v", "<", "<gv", { noremap = true, silent = true })
keymap("v", ">", ">gv", { noremap = true, silent = true})

-- remove search highlight
keymap("n", "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })

-- lsp/code/diagnostics
keymap("n", "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap("n", "<leader>ca", "<cmd>lua require('vscode').action('problems.action.showQuickFixes')<CR>")
keymap("n", "<leader>co", "<cmd>lua require('vscode').action('editor.action.organizeImports')<CR>")
keymap("n", "<leader>cr", "<cmd>lua require('vscode').action('editor.action.rename')<CR>")

keymap("n", "<leader>cf", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", { desc = "Format Document" })

keymap("n", "gr", "<cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>")

