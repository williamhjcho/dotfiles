return {
  -- https://github.com/yetone/avante.nvim
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- for providers='copilot'
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = {
            -- auto_trigger = true,
            hide_during_completion = false,
            debounce = 75,
          },
        },
      },
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {},
    opts = {
      provider = "claude",
      auto_suggestions_provider = "copilot",
      behaviour = {
        auto_suggestions = true,
      },
      mappings = {
        submit = {
          normal = "<CR>",
          -- insert = "<C-CR>",
        },
        suggestion = {
          accept = "<C-l>",
          next = "<C-]>",
          prev = "<C-]>",
        },
      },
      hints = { enabled = true },
    },
    config = function(_, opts)
      require("avante").setup(opts)
      -- recommended to be executed after color scheme setup
      require("avante_lib").load()
    end,
  },
  -- github copilot
  -- {
  --   "github/copilot.vim",
  -- },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },
}
