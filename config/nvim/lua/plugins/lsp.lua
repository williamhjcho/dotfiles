return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    -- for lua only
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
      -- copilot provider
      'giuxtaposition/blink-cmp-copilot',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = {
          'snippet_forward',
          function()
            return require('sidekick').nes_jump_or_apply()
          end,
          function()
            return vim.lsp.inline_completion.get()
          end,
          'fallback',
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'copilot', 'buffer' },

        providers = {
          -- github copilot
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100, -- make copilot suggestions top priority
            async = true,
          },
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 99, -- make lazydev completions top priority
          },
        },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
  },
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    --- @module 'conform'
    --- @type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end

        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        -- general
        lua = { 'stylua' },
        sh = { 'beautysh' },
        zsh = { 'beautysh' },
        terraform_fmt = { 'terraform' },
        toml = { 'taplo' },
        json = { 'biome' },
        jsonc = { 'biome' },
        -- terraform
        hcl = { 'packer_fmt' },
        terraform = { 'terraform_fmt' },
        tf = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        -- go
        go = { 'goimports', 'gofumpt' },
        templ = { 'templ' }, -- go templ templates
        -- web/js/ts
        css = { 'biome' },
        javascript = { 'biome' },
        javascriptreact = { 'biome' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        svelte = { 'biome', lsp_format = 'first' },
        -- dart/flutter
        dart = { 'dart_format' },
        -- python
        python = {
          'ruff_fix', -- fix auto-fixable lint errors
          'ruff_format',
          'ruff_organize_imports',
        },
        -- clojure
        clojure = { lsp_format = 'fallback' },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      -- Event to trigger linters
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        --   sh = { 'shellcheck' },
        --   zsh = { 'zsh' },
        dockerfile = { 'hadolint' },
        typescript = { 'biomejs' },
        python = { 'ruff' },
      },
    },
    config = function(_, opts)
      local lint = require('lint')
      lint.linters_by_ft = opts.linters_by_ft

      local M = {}
      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        lint.try_lint()
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('whjc-nvim-lint', { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    opts = {
      closing_tags = { enabled = false },
      decorations = {
        statusline = {
          project_config = true,
          device = true,
        },
      },
    },
    keys = {
      {
        '<leader>Fl',
        '<cmd>Telescope flutter commands<cr>',
        desc = 'Flutter Commands',
      },
      {
        '<leader>Fr',
        '<cmd>FlutterRun<cr>',
        desc = 'Flutter Run',
      },
      {
        '<leader>Fq',
        '<cmd>FlutterQuit<cr>',
        desc = 'Flutter Quit',
      },
      {
        '<leader>Fdc',
        '<cmd>FlutterCopyProfilesUrl<cr>',
        desc = 'Flutter DevTools Copy URL',
      },
      -- {
      --   '<leader>co',
      --   LazyVim.lsp.action['source.organizeImports'],
      --   desc = 'Organize Imports',
      -- },
    },
  },
}
