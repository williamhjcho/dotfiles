---@diagnostic disable: missing-fields

return {
  {
    "echasnovski/mini.comment",
    keys = {
      -- comment line
      { "<leader>/", "gcc", remap = true, mode = { "n" }, desc = "Toggle comment" },
      -- comment selection
      { "<leader>/", "gc", remap = true, mode = { "v" }, desc = "Toggle selection comment" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- General
        yamlls = {
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = { enable = true },
              validate = true,
              schemaStore = {
                -- Must disable built-in schema store support to use
                -- schemas from the plugin
                enable = false,
                -- avoid TypeError; cannot read properties of undefined
                url = "",
              },
            },
          },
        },
        taplo = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},

        -- Python
        pyright = {},

        -- js/ts
        tsserver = {},
        biome = {},

        -- go
        gopls = {},

        -- web
        tailwindcss = {},

        -- flutter/dart
        -- currently managed by flutter-tools
        -- dartls = {},
      },

      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            require("lazyvim.util").lsp.on_attach(function(client, _)
              if client.name == "yamlls" then
                client.server_capabilities.documentFormattingProvider = true
              end
            end)
          end
        end,

        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@class ConformOpts
    opts = {
      format = {},

      formatters_by_ft = {
        -- General
        sh = { "shfmt" },
        lua = { "stylua" },
        markdown = { "markdownlint" },
        python = { "ruff_format" },
        dart = { "dart_format" },
        -- issue with yamlfix where it keeps fixing root level lists
        -- yaml = { "yamlfix" },
        typescript = { "biome" },
        go = { "gofmt" },
        toml = { "taplo" },
      },

      -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
      formatters = {
        yamlfix = {
          env = {
            YAMLFIX_EXPLICIT_START = "false",
            YAMLFIX_SEQUENCE_STYLE = "keep_style",
            YAMLFIX_WHITELINES = "1",
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
        zsh = { "zsh" },
        python = { "ruff" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        typescript = { "biomejs" },
        go = { "golangcilint" },
      },

      linters = {},
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- extending on top of the default list
      vim.list_extend(opts.ensure_installed, {
        -- defaults
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "luap",

        -- general
        "bash",
        "diff",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "regex",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "query",
        "make",

        -- code
        "jsdoc",
        "javascript",
        "typescript",
        "tsx",

        "ruby",

        "dart",

        "java",
        "groovy",

        "python",

        "go",
        "gomod",
        "gosum",
        "gowork",
      })

      -- issue with dart files slowdown
      -- https://github.com/akinsho/flutter-tools.nvim/issues/267
      opts.indent.disable = { "dart" }
      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- vim
        "stylua",

        -- general
        "yamllint",
        "yamlfix",
        "json-lsp",
        "markdownlint",
        "marksman",
        "hadolint", -- dockerfile
        "taplo", -- toml

        -- shell
        "bash-language-server",
        "shellcheck",
        "shfmt",

        -- python
        "ruff",
        "ruff-lsp",
        "pyright",
        -- "debugpy",

        -- go
        "gopls",
        "golangci-lint",

        -- js/ts
        "typescript-language-server",
        "eslint-lsp",
        "biome",

        -- web
        "tailwindcss-language-server",
      },
    },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("flutter-tools").setup({
        closing_tags = { enabled = false },
        decorations = {
          statusline = {
            project_config = true,
            device = true,
          },
        },
      })
      require("telescope").load_extension("flutter")
    end,
    keys = {
      {
        "<leader>Fl",
        "<cmd>Telescope flutter commands<cr>",
        desc = "Flutter Commands",
      },
      {
        "<leader>Fr",
        "<cmd>FlutterRun<cr>",
        desc = "Flutter Run",
      },
      {
        "<leader>Fq",
        "<cmd>FlutterQuit<cr>",
        desc = "Flutter Quit",
      },
      {
        "<leader>Fdc",
        "<cmd>FlutterCopyProfilesUrl<cr>",
        desc = "Flutter DevTools Copy URL",
      },
    },
  },
}
