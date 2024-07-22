return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- storm, moon, night, day
      style = "moon",
      on_colors = function(colors)
        -- makes comments a little brighter so its easier to see
        colors.comment = "#7c86bf"
      end,
    },
  },
}
