return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      -- disabling these keymaps
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      -- sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      -- open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          -- If you set this to `true`, all "hide" just mean "dimmed out"
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            "__pycache__",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          -- remains visible even if other settings would normally hide it
          always_show = {
            ".env*",
          },
          -- remains hidden even if visible is toggled to true, this overrides always_show
          never_show = {
            ".DS_Store",
            "__pycache__",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
      },
    },
  },
}
