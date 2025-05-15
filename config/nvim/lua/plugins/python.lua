-- managed by lazy extras
return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { ensure_installed = { "python", "ninja", "rst" } },
  -- },
  -- {
  --   "mason.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "pyright",
  --       "basedpyright",
  --       "debugpy",
  --       "ruff",
  --       "ruff-lsp",
  --     })
  --   end,
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.servers, {
  --       python = {
  --         settings = {
  --           pyright = {
  --             analysis = {
  --               autoSearchPaths = true,
  --               useLibraryCodeForTypes = true,
  --               diagnosticMode = "openFilesOnly",
  --               autoImportCompletions = true,
  --             },
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-dap",
  --     "mfussenegger/nvim-dap-python", --optional
  --     { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  --   },
  --   lazy = false,
  --   branch = "regexp", -- This is the regexp branch, use this for the new version
  --   config = function()
  --     require("venv-selector").setup()
  --   end,
  --   keys = {
  --     -- { ",v", "<cmd>VenvSelect<cr>" },
  --   },
  -- },
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "nvim-neotest/neotest-python",
  --   },
  --   opts = {
  --     adapters = {
  --       ["neotest-python"] = {},
  --     },
  --   },
  -- },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { python = { "ruff" } },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { python = { "ruff_format" } },
    },
  },
}
