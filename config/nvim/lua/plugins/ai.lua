return {
  -- https://github.com/yetone/avante.nvim
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      behaviour = {
        auto_suggestions = false,
      },
      mappings = {
        suggestion = {
          accept = "<C-l>",
          next = "<C-]>",
          prev = "<C-]>",
        },
      },
    },
  },
  -- github copilot
  -- {
  --   "github/copilot.vim",
  -- },
  -- {
  --   "Exafunction/codeium.vim",
  --   enabled = false,
  --   event = "BufEnter",
  -- },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    opts = {
      model = "claude-sonnet-4",
      mappings = {
        reset = {
          normal = "",
          insert = "",
        },
      },
      prompts = {
        WHJCDEV = {
          sticky = {
            "The current project is a golang application that uses htmx, tailwindcss (with daisyUI) and templ to generate the pages.",
            "#files:**/*.templ",
            "#files:**/input.css",
          },
        },
      },
    },
  },
}
