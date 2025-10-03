return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'BufReadPost',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     -- the main github copilot integration
  --     'zbirenbaum/copilot.lua',
  --     { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
  --   },
  --   branch = 'main',
  --   opts = {
  --     model = 'claude-sonnet-4',
  --     mappings = {
  --       reset = {
  --         -- remove these conflicting keybinds
  --         normal = '',
  --         insert = '',
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     local chat = require('CopilotChat')
  --     -- remove line numbers from copilot chat panel
  --     vim.api.nvim_create_autocmd('BufEnter', {
  --       pattern = 'copilot-chat',
  --       callback = function()
  --         vim.opt_local.relativenumber = false
  --         vim.opt_local.number = false
  --       end,
  --     })
  --     chat.setup(opts)
  --   end,
  --   keys = {
  --     {
  --       '<leader>a',
  --       '',
  --       desc = '+ai',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<leader>aa',
  --       function()
  --         require('CopilotChat').toggle()
  --       end,
  --       desc = 'Toggle (CopilotChat)',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<leader>ax',
  --       function()
  --         require('CopilotChat').reset()
  --       end,
  --
  --       desc = 'Clear (CopilotChat)',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<leader>aq',
  --       function()
  --         vim.ui.ihnput({
  --           prompt = 'Quick Chat: ',
  --         }, function(input)
  --           if input ~= '' then
  --             require('CopilotChat').ask(input)
  --           end
  --         end)
  --       end,
  --       desc = 'Clear (CopilotChat)',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<leader>ap',
  --       function()
  --         require('CopilotChat').select_prompt()
  --       end,
  --       desc = 'Prompt Actions (CopilotChat)',
  --       mode = { 'n', 'v' },
  --     },
  --   },
  -- },
  {
    'folke/sidekick.nvim',
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = 'tmux',
          enabled = false,
        },
      },
      keys = {
        stopinsert = { '<esc><esc>', 'stopinsert', mode = 't' },
      },
    },
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require('sidekick').nes_jump_or_apply() then
            return -- jumped or applied
          end
          -- if vim.lsp.inline_completion.get() then
          --   return -- nvim native inline completions
          -- end

          -- fallback to normal tab
          return '<Tab>'
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<leader>aa',
        -- stylua: ignore
        function() require('sidekick.cli').toggle({
          name = "claude",
        }) end,
        mode = { 'n', 'v' },
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        -- stylua: ignore
        function() require('sidekick.cli').send({ selection = true }) end,
        mode = { 'v' },
        desc = 'Sidekick Send Visual Selection',
      },
      {
        '<leader>ap',
        -- stylua: ignore
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'v' },
        desc = 'Sidekick Select Prompt',
      },
      {
        '<c-.>',
        -- stylua: ignore
        function() require('sidekick.cli').focus() end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
    },
  },
}
