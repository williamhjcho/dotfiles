return {
  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    enabled = false,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
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
    config = function()
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
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        dart = { "dart_format" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "sidlatau/neotest-dart",
    },
    opts = {
      adapters = {
        "neotest-dart",
      },
    },
  },
}
