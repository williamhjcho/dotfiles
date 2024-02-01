return {
  -- color schemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "moon" },
  },
  {
    "sainnhe/everforest",
    lazy = false,
    config = function()
      -- hard | medium (default) | soft
      vim.g.everforest_background = "hard"
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = { flavour = "mocha" },
  },
  ---
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          -- visible = true,
          hide_dotfiles = false,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable keymap to grep files
      -- used for comments
      { "<leader>/", false },
    },
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      -- the mapping is assumed to be in another key
      -- run <leader>ch to see copilot mapping section
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
    ---@type LazyKeysSpec[]
    keys = {
      {
        "<C-l>",
        function()
          vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
        end,
        mode = { "i" },
        desc = "Copilot Accept",
        replace_keycodes = true,
        nowait = true,
        silent = true,
        expr = true,
        noremap = true,
      },
    },
  },
}
