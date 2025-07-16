return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- storm, moon, night, day
      style = 'moon',
      on_colors = function(colors)
        -- makes comments a little brighter so its easier to see
        colors.comment = '#7c86bf'
      end,
      on_highlights = function(hl, c)
        hl.LineNr.fg = c.comment
        hl.LineNrAbove.fg = c.comment
        hl.LineNrBelow.fg = c.comment
        -- hl.CursorLineNr.fg = "#00FF00"
        -- gl.DiagnosticUnnecessary = { fg = commentColor }
      end,
    },
    init = function()
      vim.cmd.colorscheme('tokyonight')
    end,
  },

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          -- pick = function(cmd, opts)
          --   return LazyVim.pick(cmd, opts)()
          -- end,
          header = [[
        ╔══════════════════════════════════════╗
        ║  ██╗    ██╗██╗  ██╗     ██╗ ██████╗  ║
        ║  ██║    ██║██║  ██║     ██║██╔════╝  ║
        ║  ██║ █╗ ██║███████║     ██║██║       ║
        ║  ██║███╗██║██╔══██║██   ██║██║       ║
        ║  ╚███╔███╔╝██║  ██║╚█████╔╝╚██████╗  ║
        ║   ╚══╝╚══╝ ╚═╝  ╚═╝ ╚════╝  ╚═════╝  ║
        ╚══════════════════════════════════════╝
 ]],
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
      },
      indent = { enabled = true },
    },
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        -- diagnostics_indicator = function(_, _, diag)
        --   local icons = LazyVim.config.icons.diagnostics
        --   local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
        --   return vim.trim(ret)
        -- end,
        offsets = {
          { filetype = 'snacks_layout_box' },
        },
        ---@param opts bufferline.IconFetcherOpts
        -- get_element_icon = function(opts)
        --   return LazyVim.config.icons.ft[opts.filetype]
        -- end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  { 'j-hui/fidget.nvim', opts = {} },
}
