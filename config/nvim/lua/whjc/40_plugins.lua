local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
local add = vim.pack.add

now(function()
  vim.pack.add({
    -- 'https://github.com/navarasu/onedark.nvim',
    -- 'https://github.com/folke/tokyonight.nvim',
    'https://github.com/serhez/teide.nvim',
    -- 'https://github.com/rebelot/kanagawa.nvim',
  })

  require('teide').setup({
    style = 'dark', -- darker, dark, dimmed, light
  })
  -- require('onedark').setup({ style = 'cool' })
  -- require('tokyonight').setup({
  --   -- storm, moon, night, day
  --   style = 'moon',
  --   on_colors = function(colors)
  --     -- makes comments a little brighter so its easier to see
  --     colors.comment = '#7c86bf'
  --   end,
  --   on_highlights = function(hl, c)
  --     hl.LineNr.fg = c.comment
  --     hl.LineNrAbove.fg = c.comment
  --     hl.LineNrBelow.fg = c.comment
  --     -- hl.CursorLineNr.fg = "#00FF00"
  --     -- gl.DiagnosticUnnecessary = { fg = commentColor }
  --   end,
  -- })
  -- require('kanagawa').setup({
  --   -- wave, dragon, lotus
  --   theme = 'wave',
  -- })
  vim.cmd('colorscheme teide')
end)

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

  local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then ts.install(to_install) end

  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end

  -- extra explicit filtypes registration
  vim.iter(require('whjc.languages')):each(function(lang)
    if lang.filetypes then vim.filetype.add(lang.filetypes) end
  end)

  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
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

later(function()
  add({ 'https://github.com/christoomey/vim-tmux-navigator' })

  -- Move to window using <ctrl> hjkl keys `:help wincmd`
  -- only install if vim-tmux-navigator is not available, since it already provides this keymaps
  if vim.fn.exists(':TmuxNavigateLeft') == 0 then
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Go to left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Go to right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Go to lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Go to upper window' })
  else
    -- disable tmux keymaps for lazygit integration
    vim.keymap.del('t', '<C-h>')
    vim.keymap.del('t', '<C-l>')
    vim.keymap.del('t', '<C-j>')
    vim.keymap.del('t', '<C-k>')
  end
end)

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

  local formatters = vim
    .iter(require('whjc.languages'))
    :map(function(i) return i.formatters end)
    :filter(function(i) return i end)
    :fold({}, function(acc, formatters) return vim.tbl_extend('force', acc, formatters) end)

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

later(function()
  add({ 'https://github.com/mfussenegger/nvim-lint' })

  local lint = require('lint')
  local linters = vim
    .iter(require('whjc.languages'))
    :map(function(i) return i.linters end)
    :filter(function(i) return i end)
    :fold({}, function(acc, linters) return vim.tbl_extend('force', acc, linters) end)
  lint.linters_by_ft = linters

  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
    group = vim.api.nvim_create_augroup('whjc_nvim_lint', { clear = true }),
    callback = function() require('lint').try_lint() end,
  })
end)

later(function() add({ 'https://github.com/rafamadriz/friendly-snippets' }) end)

later(function()
  add({ 'https://github.com/NMAC427/guess-indent.nvim' })
  require('guess-indent').setup({})
end)

later(function()
  add({ 'https://github.com/lewis6991/gitsigns.nvim' })
  require('gitsigns').setup({})
end)

later(function()
  add({ 'https://github.com/folke/ts-comments.nvim' })
  require('ts-comments').setup({})
end)

later(function()
  add({ 'https://github.com/windwp/nvim-ts-autotag' })
  require('nvim-ts-autotag').setup({})
end)

later(function()
  add({ 'https://github.com/MagicDuck/grug-far.nvim' })
  require('grug-far').setup({
    headerMaxWidth = 80,
  })
end)

later(function()
  add({ 'https://github.com/folke/persistence.nvim' })
  require('persistence').setup({})
end)

later(function()
  add({ 'https://github.com/folke/which-key.nvim' })
  require('which-key').setup({
    preset = 'helix',
    defaults = {},
    spec = {
      { '<leader><tab>', group = 'tabs' },
      { '<leader>b', group = 'buffer' },
      { '<leader>c', group = 'code' },
      { '<leader>d', group = 'debug' },
      { '<leader>f', group = 'file|find' },
      { '<leader>q', group = 'quit|session' },
      { '<leader>s', group = 'search' },
      { '<leader>x', group = 'diagnostics|quickfix' },
      { 'g', group = 'goto' },
      { 'gs', group = 'surround' },
      { 'z', group = 'fold' },
    },
  })
end)

later(function()
  add({ 'https://github.com/folke/snacks.nvim' })
  require('snacks').setup({
    indent = { enabled = true },
    lazygit = {},
    explorer = {},
    picker = {},
  })
end)

later(function()
  add({ 'https://github.com/chrisgrieser/nvim-origami' })
  require('origami').setup({
    autoFold = { enabled = false },
    foldKeymaps = {
      closeOnlyOnFirstColumn = true,
    },
  })
end)

later(function() add({ 'https://github.com/b0o/SchemaStore.nvim' }) end)

later(function()
  add({
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',

    -- adapters
    'https://github.com/sidlatau/neotest-dart',
    'https://github.com/fredrikaverpil/neotest-golang',
  })

  require('neotest').setup({
    status = { virtual_text = true },
    output = { open_on_run = true },
    adapters = {
      require('neotest-golang')({
        dap_go_enabled = true, -- requires leoluz/nvim-dap-go
      }),
      require('neotest-dart')({
        command = 'flutter',
        use_lsp = true,
      }),
    },
  })

  vim.keymap.set('n', '<leader>t', '', { desc = '+test' })
  vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = 'Run File (Neotest)' })
  vim.keymap.set('n', '<leader>tT', function() require('neotest').run.run(vim.uv.cwd()) end, { desc = 'Run All Test Files (Neotest)' })
  vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run() end, { desc = 'Run Nearest (Neotest)' })
  vim.keymap.set('n', '<leader>tl', function() require('neotest').run.run_last() end, { desc = 'Run Last (Neotest)' })
  vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = 'Toggle Summary (Neotest)' })
  vim.keymap.set('n', '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, { desc = 'Show Output (Neotest)' })
  vim.keymap.set('n', '<leader>tO', function() require('neotest').output_panel.toggle() end, { desc = 'Toggle Output Panel (Neotest)' })
  vim.keymap.set('n', '<leader>tS', function() require('neotest').run.stop() end, { desc = 'Stop (Neotest)' })
  vim.keymap.set('n', '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, { desc = 'Toggle Watch (Neotest)' })

  -- requires nvim-dap
  vim.keymap.set('n', '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, { desc = 'Debug Nearest' })
end)

later(function()
  add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',

    -- dependencies
    'https://github.com/leoluz/nvim-dap-go',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/theHamsta/nvim-dap-virtual-text', -- virtual text for the debugger
    'https://github.com/nvim-neotest/nvim-nio',
  })

  -- load mason-nvim-dap here, after all adapters have been setup
  -- if LazyVim.has('mason-nvim-dap.nvim') then
  --   require('mason-nvim-dap').setup(LazyVim.opts('mason-nvim-dap.nvim'))
  -- end
  --
  -- vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  --
  -- for name, sign in pairs(LazyVim.config.icons.dap) do
  --   sign = type(sign) == 'table' and sign or { sign }
  --   vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
  -- end

  -- setup dap config by VsCode launch.json file
  local vscode = require('dap.ext.vscode')
  local json = require('plenary.json')
  vscode.json_decode = function(str) return vim.json.decode(json.json_strip_comments(str)) end

  local dap = require('dap')
  local dapui = require('dapui')
  dapui.setup({})
  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end

  vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: See last session result.' })
  vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })

  vim.keymap.set('n', '<leader>du', function() require('dapui').toggle({}) end, { desc = 'Dap UI' })
  vim.keymap.set({ 'n', 'v' }, '<leader>de', function() require('dapui').eval() end, { desc = 'Eval' })

  -- vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Breakpoint Condition' })
  -- vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
  -- vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Run/Continue' })
  -- vim.keymap.set('n', '<leader>da', function() require('dap').continue({ before = get_args }) end, { desc = 'Run with Args' })
  -- vim.keymap.set('n', '<leader>dC', function() require('dap').run_to_cursor() end, { desc = 'Run to Cursor' })
  -- vim.keymap.set('n', '<leader>dg', function() require('dap').goto_() end, { desc = 'Go to Line (No Execute)' })
  -- vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step Into' })
  -- vim.keymap.set('n', '<leader>dj', function() require('dap').down() end, { desc = 'Down' })
  -- vim.keymap.set('n', '<leader>dk', function() require('dap').up() end, { desc = 'Up' })
  -- vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Run Last' })
  -- vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'Step Out' })
  -- vim.keymap.set('n', '<leader>dO', function() require('dap').step_over() end, { desc = 'Step Over' })
  -- vim.keymap.set('n', '<leader>dP', function() require('dap').pause() end, { desc = 'Pause' })
  -- vim.keymap.set('n', '<leader>dr', function() require('dap').repl.toggle() end, { desc = 'Toggle REPL' })
  -- vim.keymap.set('n', '<leader>ds', function() require('dap').session() end, { desc = 'Session' })
  -- vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = 'Terminate' })
  -- vim.keymap.set('n', '<leader>dw', function() require('dap.ui.widgets').hover() end, { desc = 'Widgets' })
end)
