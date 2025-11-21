vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('^1') },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('^2') },
  -- {
  --   'rafamadriz/friendly-snippets',
  --   config = function()
  --     require('luasnip.loaders.from_vscode').lazy_load()
  --   end,
  -- },
  -- copilot provider
  -- 'giuxtaposition/blink-cmp-copilot',
}, { confirm = false })

local blink = require('blink.cmp')
blink.setup({
  keymap = {
    preset = 'default',
    -- ['<Tab>'] = {
    --   'snippet_forward',
    --   function()
    --     return require('sidekick').nes_jump_or_apply()
    --   end,
    --   function()
    --     return vim.lsp.inline_completion.get()
    --   end,
    --   'fallback',
    -- },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  sources = {
    -- default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot', 'buffer' },
    default = { 'lsp', 'path', 'snippets', 'buffer' },

    providers = {
      -- github copilot
      -- copilot = {
      --   name = 'copilot',
      --   module = 'blink-cmp-copilot',
      --   score_offset = 100, -- make copilot suggestions top priority
      --   async = true,
      -- },
      -- lazydev = {
      --   module = 'lazydev.integrations.blink',
      --   score_offset = 99, -- make lazydev completions top priority
      -- },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
})

-- local p = {
--   'saghen/blink.cmp',
--   event = 'VimEnter',
--   version = '1.*',
--   dependencies = {
--     -- Snippet Engine
--     {
--       'L3MON4D3/LuaSnip',
--       version = '2.*',
--       build = (function()
--         -- Build Step is needed for regex support in snippets.
--         -- This step is not supported in many windows environments.
--         -- Remove the below condition to re-enable on windows.
--         if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
--           return
--         end
--         return 'make install_jsregexp'
--       end)(),
--       dependencies = {
--         -- `friendly-snippets` contains a variety of premade snippets.
--         --    See the README about individual language/framework/plugin snippets:
--         --    https://github.com/rafamadriz/friendly-snippets
--         -- {
--         --   'rafamadriz/friendly-snippets',
--         --   config = function()
--         --     require('luasnip.loaders.from_vscode').lazy_load()
--         --   end,
--         -- },
--       },
--       opts = {},
--     },
--     'folke/lazydev.nvim',
--     -- copilot provider
--     'giuxtaposition/blink-cmp-copilot',
--   },
--   -- opts_extend = { 'sources.default' },
-- }
