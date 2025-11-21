-- stylua: ignore
local languages = vim
  .iter(require('whjc.languages'))
  :map(function(i) return i.treesitter end)
  :filter(function(i) return i end)
  :flatten()
  :totable()

local ts = require('nvim-treesitter')
ts.setup({
  ensure_installed = languages,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})

-- local to_install = opts.ensure_installed
-- local already_installed = ts.get_installed()
-- to_install = vim
--   .iter(to_install)
--   :filter(function(parser)
--     return not vim.tbl_contains(already_installed, parser)
--   end)
--   :totable()
-- if #to_install > 0 then
--   ts.install(to_install)
-- end

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('whjc_treesitter_start', { clear = true }),
  callback = function(ev)
    local ft = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if not lang or not vim.treesitter.language.add(lang) then
      return
    end

    -- if vim.tbl_get(opts, 'highlight', 'enable') ~= false then
    vim.treesitter.start()
    -- end

    -- if vim.treesitter.query.get(lang, 'folds') then
    --   vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- end
    -- if vim.treesitter.query.get(lang, 'indents') then
    --   vim.wo.indentexpr = 'nvim_treesitter#indent()'
    -- end
  end,
})
