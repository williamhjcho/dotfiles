return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- storm, moon, night, day
      style = "moon",
      light_style = "day",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- styles can be dark, transparent, or normal
        sidebars = "dark",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.comment = "#7c86bf"
      end,
      -- on_highlights = function(highlights, colors) end,
    },
  },
}
