return {
  {
    "mason.nvim",
    opts = { ensure_installed = { "debugpy" } },
  },
  -- {
  --   "linux-cultist/venv-selector.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "nvim-telescope/telescope.nvim",
  --     "mfussenegger/nvim-dap-python",
  --   },
  --   branch = "regexp",
  --   opts = {
  --     -- Your options go here
  --     -- name = "venv",
  --     auto_refresh = true,
  --   },
  --   event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  --   keys = {
  --     -- Keymap to open VenvSelector to pick a venv.
  --     { "<leader>pvs", "<cmd>VenvSelect<cr>" },
  --     -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
  --     -- { '<leader>pvc', '<cmd>VenvSelectCached<cr>' },
  --   },
  -- },
}
