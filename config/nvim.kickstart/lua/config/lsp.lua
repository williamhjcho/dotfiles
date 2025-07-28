-- Disable the default keybinds
for _, bind in ipairs({ 'grn', 'gra', 'gri', 'grr' }) do
  pcall(vim.keymap.del, 'n', bind)
end

vim.lsp.config('biome', {
  filetypes = {
    'astro',
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
    'vue',
  },
})
vim.lsp.config('vtsls', {
  -- explicitly add default filetypes, so that we can extend
  -- them in related extras
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  settings = {
    complete_function_calls = true,
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          {
            name = 'typescript-svelte-plugin',
            location = vim.fn.expand('$MASON/packages/svelte-language-server/node_modules/typescript-svelte-plugin'),
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },

  -- - biome (id: 2)
  --   - Version: 2.1.1
  --   - Root directory: ~/dev/williamhjcho/splitbill
  --   - Command: { "biome", "lsp-proxy" }
  --   - Settings: vim.empty_dict()
  --   - Attached buffers: 49, 55

  -----
  -- {
  --     complete_function_calls = true,
  --     javascript = {
  --       inlayHints = <1>{
  --         enumMemberValues = {
  --           enabled = true
  --         },
  --         functionLikeReturnTypes = {
  --           enabled = true
  --         },
  --         parameterNames = {
  --           enabled = "literals"
  --         },
  --         parameterTypes = {
  --           enabled = true
  --         },
  --         propertyDeclarationTypes = {
  --           enabled = true
  --         },
  --         variableTypes = {
  --           enabled = false
  --         }
  --       },
  --       suggest = <2>{
  --         completeFunctionCalls = true
  --       },
  --       updateImportsOnFileMove = <3>{
  --         enabled = "always"
  --       }
  --     },
  --     typescript = {
  --       inlayHints = <table 1>,
  --       suggest = <table 2>,
  --       updateImportsOnFileMove = <table 3>
  --     },
  --     vtsls = {
  --       autoUseWorkspaceTsdk = true,
  --       enableMoveToFileCodeAction = true,
  --       experimental = {
  --         completion = {
  --           enableServerSideFuzzyMatch = true
  --         },
  --         maxInlayHintLength = 30
  --       },
  --       tsserver = {
  --         globalPlugins = { {
  --             enableForWorkspaceTypeScriptVersions = true,
  --             location = "/Users/william.cho/.local/share/nvim/mason/packages/svelte-language-server//node_modules/typescript-svelte-plugin",
  --             name = "typescript-svelte-plugin"
  --           } }
  --       }
  --     }
  --   }
})
vim.lsp.config('svelte', {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
  },
})

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

vim.lsp.enable({
  'lua_ls',
  'gopls', -- go LSP
  'taplo', -- TOML LSP
  'yamlls', -- YAML LSP
  'biome', -- general web formatter & linter (js, ts, json, etc)
  'vtsls', -- javscript/typescript LSP -- same as lazy.nvim
  'svelte', -- svelte LSP
  'tailwindcss', -- tailwind css LSP
  'clojure_lsp', -- Clojure LSP
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('whjc-lsp-attach', { clear = true }),
  callback = function(event)
    local Snacks = require('snacks')
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- stylua: ignore start
    map('K', vim.lsp.buf.hover, 'Open Hover')
    map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definitions')
    map('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declarations')
    map('gr', function() Snacks.picker.lsp_references() end, 'Goto References')
    map('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementations')
    map('grn', vim.lsp.buf.rename, 'Rename')
    map('gra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions', {'n', 'x'})
    map('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
    -- stylua: ignore end

    map('<leader>cF', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.fixAll' }, diagnostics = {} },
        apply = true,
      })
    end, 'Code Fix All', { 'n', 'x' })
    map('<leader>co', function()
      local ft = vim.bo.filetype
      local clients = vim.lsp.get_clients({ bufnr = 0 })
        -- stylua: ignore
        local client_has_name = function(name)
          return vim.tbl_contains(vim.tbl_map(function(c) return c.name end, clients), name)
        end

      -- overriding vtsls organize imports with biome
      if client_has_name('biome') and vim.tbl_contains({ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'svelte' }, ft) then
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

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
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

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
