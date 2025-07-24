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

  --       inlay_hints = {
  --         enabled = false,
  --       },
  --       servers = {
  --         -- web
  --         html = {
  --           filetypes = { 'html', 'templ' },
  --         },
  --         htmx = {
  --           filetypes = { 'html', 'templ' },
  --         },
  --         tailwindcss = {},
  --         -- docker
  --         dockerls = {},
  --         -- yaml/ toml
  --         yamlls = {
  --           -- Have to add this for yamlls to understand that we support line folding
  --           capabilities = {
  --             textDocument = {
  --               foldingRange = {
  --                 dynamicRegistration = false,
  --                 lineFoldingOnly = true,
  --               },
  --             },
  --           },
  --           -- lazy-load schemastore when needed
  --           on_new_config = function(new_config)
  --             new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
  --           end,
  --           settings = {
  --             redhat = { telemetry = { enabled = false } },
  --             yaml = {
  --               keyOrdering = false,
  --               format = {
  --                 enable = true,
  --               },
  --               validate = true,
  --               -- Must disable built-in schemaStore support to use
  --               -- schemas from SchemaStore.nvim plugin
  --               schemaStore = {
  --                 enable = false,
  --                 url = '',
  --               },
  --             },
  --           },
  --         },
  --         taplo = {},
  --         -- clojure
  --         clojure_lsp = {},

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason-org/mason.nvim',
      -- Useful status updates for LSP.
      'j-hui/fidget.nvim',
      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('whjc-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- stylua: ignore start
          map('K', function() vim.lsp.buf.hover() end, 'Open Hover')
          map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definitions')
          map('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declarations')
          map('gr', function() Snacks.picker.lsp_references() end, 'Goto References')
          map('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementations')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions', {'n', 'x'})
          map('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
          -- stylua: ignore end

          map('<leader>co', function()
            local ft = vim.bo.filetype
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            -- stylua: ignore
            local client_has_name = function(name)
              return vim.tbl_contains(vim.tbl_map(function(c) return c.name end, clients), name)
            end

            -- overriding vtsls organize imports with biome
            if client_has_name('biome') and vim.tbl_contains({ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }, ft) then
              vim.lsp.buf.code_action({
                context = { only = { 'source.fixAll.biome' }, diagnostics = {} },
                apply = true,
              })
            else
              vim.lsp.buf.code_action({
                context = { only = { 'source.organizeImports' }, diagnostics = {} },
                apply = true,
              })
            end
          end, 'Organize Imports')
          --
          -- map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- -- Find references for the word under your cursor.
          -- map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- --
          -- -- Jump to the implementation of the word under your cursor.
          -- --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          --
          -- -- Jump to the definition of the word under your cursor.
          -- --  This is where a variable was first declared, or where a function is defined, etc.
          -- --  To jump back, press <C-t>.
          -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          --
          -- -- WARN: This is not Goto Definition, this is Goto Declaration.
          -- --  For example, in C this would take you to the header.
          -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          --
          -- -- Fuzzy find all the symbols in your current document.
          -- --  Symbols are things like variables, functions, types, etc.
          -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          --
          -- -- Fuzzy find all the symbols in your current workspace.
          -- --  Similar to document symbols, except searches over your entire project.
          -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          --
          -- -- Jump to the type of the word under your cursor.
          -- --  Useful when you're not sure what type a variable is and you want to see
          -- --  the definition of its *type*, not where it was *defined*.
          -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has('nvim-0.11') == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('whjc-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('whjc-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Disable the default keybinds
      for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr' }) do
        pcall(vim.keymap.del, 'n', bind)
      end

      -- LSP Commands
      -- vim.api.nvim_create_user_command('LspInfo', function()
      --   vim.cmd('silent checkhealth vim.lsp')
      -- end, { desc = 'LSP info' })
      --
      -- vim.api.nvim_create_user_command('LspStop', function()
      --   vim.cmd('vim.lsp.stop_client(vim.lsp.get_clients())')
      -- end, { desc = 'Stop LSP clients on buffer(s)' })
      --
      -- vim.api.nvim_create_user_command('LspRestart', function()
      --   local bufnr = vim.api.nvim_get_current_buf()
      --   local clients = vim.lsp.get_clients({ bufnr = bufnr })
      --
      --   for _, client in ipairs(clients) do
      --     vim.lsp.stop_client(client.id)
      --   end
      --
      --   vim.defer_fn(function()
      --     vim.cmd('edit')
      --   end, 100)
      -- end, { desc = 'Restarts LSP clients on current buffer' })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      -- enable the LSPs
      vim.lsp.enable({
        'lua_ls',
        'gopls', -- go LSP
        'taplo', -- TOML LSP
        'yaml_ls',
        'biome', -- general web formatter & linter (js, ts, json, etc)
        'vtsls', -- javscript/typescript LSP -- same as lazy.nvim
        'tailwindcss', -- tailwind css LSP
        'clojure_lsp', -- Clojure LSP
      })
    end,
  },

  --     TODO: add some of these keybinds for fzf
  --     local builtin = require('telescope.builtin')
  --     vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  --     vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  --     vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  --     vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  --     vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  --     vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  --     vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  --     vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  --     vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  --     vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  --
  --     -- Slightly advanced example of overriding default behavior and theme
  --     vim.keymap.set('n', '<leader>/', function()
  --       -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  --       builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
  --         winblend = 10,
  --         previewer = false,
  --       }))
  --     end, { desc = '[/] Fuzzily search in current buffer' })
  --
  --     -- It's also possible to pass additional configuration options.
  --     --  See `:help telescope.builtin.live_grep()` for information about particular keys
  --     vim.keymap.set('n', '<leader>s/', function()
  --       builtin.live_grep({
  --         grep_open_files = true,
  --         prompt_title = 'Live Grep in Open Files',
  --       })
  --     end, { desc = '[S]earch [/] in Open Files' })
  --
  --     -- Shortcut for searching your Neovim configuration files
  --     vim.keymap.set('n', '<leader>sn', function()
  --       builtin.find_files({ cwd = vim.fn.stdpath('config') })
  --     end, { desc = '[S]earch [N]eovim files' })
  --   end,
  -- },

  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
  },
}
