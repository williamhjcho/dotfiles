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
  add({ 'https://github.com/mason-org/mason.nvim' })

  require('mason').setup()

  -- stylua: ignore
  local packages = vim
    .iter(require('whjc.languages'))
    :map(function(i) return i.mason end)
    :filter(function(i) return i end)
    :flatten()
    :totable()
  local registry = require('mason-registry')

  local function install_packages()
    for _, name in ipairs(packages) do
      if registry.has_package(name) then
        local p = registry.get_package(name)
        if not p:is_installed() then p:install() end
      end
    end
  end
  registry.refresh(install_packages)
end)

now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  require('whjc.lsp')
end)

later(function() add({ 'https://github.com/christoomey/vim-tmux-navigator' }) end)

later(function()
  add({ 'https://github.com/jake-stewart/multicursor.nvim' })

  local multicursor = require('multicursor-nvim')
  multicursor.setup()

  -- Mappings defined in a keymap layer only apply when there are
  -- multiple cursors. This lets you have overlapping mappings.
  multicursor.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    layerSet({ 'n', 'x' }, '<left>', multicursor.prevCursor)
    layerSet({ 'n', 'x' }, '<right>', multicursor.nextCursor)

    -- Delete the current cursor.
    layerSet({ 'n', 'x' }, '<leader>x', multicursor.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet('n', '<esc>', function()
      if not multicursor.cursorsEnabled() then
        multicursor.enableCursors()
      else
        multicursor.clearCursors()
      end
    end)
  end)
end)

later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  -- stylua: ignore
  local formatters = vim
    .iter(require('whjc.languages'))
    :map(function(i) return i.formatters end)
    :filter(function(i) return i end)
    :fold({}, function(acc, formatters)
      return vim.tbl_extend('force', acc, formatters)
    end)

  require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then return nil end

      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = formatters,
  })
end)

later(function() require('whjc.test') end)
