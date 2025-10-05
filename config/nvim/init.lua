require('options')

vim.pack.add({
  -- colorschemes
  { src = 'https://github.com/navarasu/onedark.nvim' },
  -- { src = 'https://github.com/rebelot/kanagawa.nvim' },
  -- { src = 'https://github.com/folke/tokyonight.nvim' },
})
vim.pack.add({
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  -- auto closes and renames html tags
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
}, { load = true })

local debug = false

local pack_plugins = vim.pack.get()
if debug then
  print(vim
    .iter(pack_plugins)
    :map(function(plugin)
      return string.format('%s (%s): %s', plugin.spec.name, tostring(plugin.active), plugin.path)
    end)
    :join('\n'))
end

local to_delete = vim
  .iter(pack_plugins)
  :filter(function(plugin)
    return not plugin.active
  end)
  :map(function(plugin)
    return plugin.spec.name
  end)
  :totable()
if #to_delete > 0 then
  if debug then
    print(string.format('Deleting packages (%d): %s', #to_delete, table.concat(to_delete, ', ')))
  end
  vim.pack.del(to_delete)
end

require('colorschemes')
-- plugin setups
require('guess-indent').setup({})
require('nvim-ts-autotag').setup({})
require('lazy-init')

-- config setups
require('keymaps')
require('autocmds')
require('lsp')
