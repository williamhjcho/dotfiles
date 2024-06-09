-- If you want to see what colorschemes are already installed, you can use
-- `:colorscheme <colorschema name>` or `:Telescope colorscheme`
return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      -- storm, moon, night, day
      style = 'moon',
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
    },
    -- init = function()
    --   vim.cmd.colorscheme 'tokyonight'
    -- end,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- variants: wave, dragon, lotus
      theme = 'wave',
      transparent = true,
      commentStyle = { italic = true },
    },
    init = function()
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
