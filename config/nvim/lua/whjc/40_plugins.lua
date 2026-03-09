local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
local add = vim.pack.add

now_if_args(function()
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  -- stylua: ignore
  local languages = vim
    .iter(require('whjc.languages'))
    :map(function(i) return i.treesitter end)
    :filter(function(i) return i end)
    :flatten()
    :totable()

  local ts = require('nvim-treesitter')
  ts.setup({})
  ts.install(languages)

  vim.iter(require('whjc.languages')):each(function(lang)
    if lang.filetypes then vim.filetype.add(lang.filetypes) end
  end)

  -- vim.api.nvim_create_autocmd('FileType', {
  --   pattern = '*',
  --   group = vim.api.nvim_create_augroup('whjc_treesitter_start', { clear = true }),
  --   callback = function(args)
  --     local ft = vim.bo.filetype
  --     local lang = vim.treesitter.language.get_lang(ft)
  --
  --     if not lang or not vim.treesitter.language.add(lang) then return end
  --
  --     pcall(vim.treesitter.start)
  --
  --     -- if vim.treesitter.query.get(lang, 'folds') then
  --     --   vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  --     -- end
  --     -- if vim.treesitter.query.get(lang, 'indents') then
  --     --   vim.wo.indentexpr = 'nvim_treesitter#indent()'
  --     -- end
  --   end,
  -- })
end)

now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  require('whjc.lsp')
end)
