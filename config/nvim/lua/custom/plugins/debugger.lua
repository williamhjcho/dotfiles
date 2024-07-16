return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()
      require('dap-go').setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebugger [C]ontinue' })
      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = '[D]ebugger [T]oggle Breakpoint' })
      -- vim.keymap.set('n', '<leader>dT', dap.set_breakpoint, { desc = '[D]ebugger Se[T] Breakpoint' })

      require('which-key').add {
        { '<leader>ds', group = '[D]ebugger [S]tep' },
      }
      vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = '[D]ebugger [S]tep [O]ver' })
      vim.keymap.set('n', '<F4>', dap.step_over, { desc = '[D]ebugger [S]tep [O]ver' })
      vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = '[D]ebugger [S]tep [I]nto' })
      vim.keymap.set('n', '<F5>', dap.step_into, { desc = '[D]ebugger [S]tep [I]nto' })
      vim.keymap.set('n', '<leader>dsu', dap.step_out, { desc = '[D]ebugger [S]tep O[u]t' })
      vim.keymap.set('n', '<F6>', dap.step_out, { desc = '[D]ebugger [S]tep O[u]t' })

      -- vim.keymap.set('n', '<leader>lp', function()
      --   dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      -- end)
      vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = '[D]ebugger [R]epl Open' })
      vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = '[D]ebugger [L]ast Run' })
      -- vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      --   require('dap.ui.widgets').hover()
      -- end)
      -- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      --   require('dap.ui.widgets').preview()
      -- end)
      -- vim.keymap.set('n', '<Leader>df', function()
      --   local widgets = require 'dap.ui.widgets'
      --   widgets.centered_float(widgets.frames)
      -- end)
      -- vim.keymap.set('n', '<Leader>ds', function()
      --   local widgets = require 'dap.ui.widgets'
      --   widgets.centered_float(widgets.scopes)
      -- end)

      -- `DapBreakpoint` for breakpoints (default: `B`)
      -- `DapBreakpointCondition` for conditional breakpoints (default: `C`)
      -- `DapLogPoint` for log points (default: `L`)
      -- `DapStopped` to indicate where the debugee is stopped (default: `→`)
      -- `DapBreakpointRejected` to indicate breakpoints rejected by the debug adapter (default: `R`)
      -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#ff3e3e', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

      vim.fn.sign_define('DapBreakpoint', { text = '¤', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
    end,
  },
}
