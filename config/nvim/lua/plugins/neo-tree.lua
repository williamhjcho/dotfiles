return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = 'v3.x',
    -- cmd = 'Neotree',
    -- dependencies = {
    --   'nvim-lua/plenary.nvim',
    --   'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    --   'MunifTanjim/nui.nvim',
    -- },
    -- keys = {
    --   {
    --     '<leader>fe',
    --     function()
    --       require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
    --     end,
    --     desc = 'Explorer NeoTree (root dir)',
    --   },
    -- },
    -- deactivate = function()
    --   vim.cmd [[Neotree close]]
    -- end,
    -- init = function()
    --   if vim.fn.argc(-1) == 1 then
    --     local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --     if stat and stat.type == 'directory' then
    --       require 'neo-tree'
    --     end
    --   end
    -- end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          -- If you set this to `true`, all "hide" just mean "dimmed out"
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            "__pycache__",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          -- remains visible even if other settings would normally hide it
          always_show = {
            ".env*",
          },
          -- remains hidden even if visible is toggled to true, this overrides always_show
          never_show = {
            ".DS_Store",
            "__pycache__",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
      },
    },
    -- config = function(_, opts)
    --   -- local function on_move(data)
    --   --   Util.lsp.on_rename(data.source, data.destination)
    --   -- end
    --
    --   -- local events = require 'neo-tree.events'
    --   -- opts.event_handlers = opts.event_handlers or {}
    --   -- vim.list_extend(opts.event_handlers, {
    --   --   { event = events.FILE_MOVED, handler = on_move },
    --   --   { event = events.FILE_RENAMED, handler = on_move },
    --   -- })
    --   require('neo-tree').setup(opts)
    --   vim.api.nvim_create_autocmd('TermClose', {
    --     pattern = '*lazygit',
    --     callback = function()
    --       if package.loaded['neo-tree.sources.git_status'] then
    --         require('neo-tree.sources.git_status').refresh()
    --       end
    --     end,
    --   })
    -- end,
  },
}
