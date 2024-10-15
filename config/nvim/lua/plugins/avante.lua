return {
  -- https://github.com/yetone/avante.nvim
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
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
      -- Make sure to setup the file types and ft properly
      "MeanderingProgrammer/render-markdown.nvim",
    },
    keys = {},
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      behaviour = {
        auto_suggestions = false,
      },
      mappings = {
        submit = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
      -- recommended to be executed after color scheme setup
      require("avante_lib").load()
    end,
  },
}
