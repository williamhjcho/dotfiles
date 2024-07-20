return {
  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = function()
      local opts = {
        closing_tags = { enabled = false },
        decorations = {
          statusline = {
            project_config = true,
            device = true,
          },
        },
      }
      require("telescope").load_extension("flutter")
      return opts
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
