return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ---@class snacks.dashboard.Config
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      ---@class snacks.scroll.Config
      scroll = {
        animate = {
          duration = {
            step = 15,
            total = 100,
          },
        },
        animate_repeat = {
          delay = 50,
        },
      },
    },
  },
}
