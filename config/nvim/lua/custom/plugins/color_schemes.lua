-- If you want to see what colorschemes are already installed, you can use
-- `:colorscheme <colorschema name>` or `:Telescope colorscheme`
return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- storm, moon, night, day
      style = 'moon',
      light_style = 'day',
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- styles can be dark, transparent, or normal
        sidebars = 'dark',
        floats = 'transparent',
      },
      on_colors = function(colors)
        colors.comment = '#7c86bf'
      end,
      -- on_highlights = function(highlights, colors) end,
    },
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      -- variants: wave, dragon, lotus
      theme = 'wave',
      transparent = true,
      commentStyle = { italic = true },
    },
    config = function()
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
