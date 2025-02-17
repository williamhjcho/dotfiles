return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
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
