return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "css",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "json5",
        "tsx",
        "typescript",
        "astro",
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "typescript-language-server",
        "tailwindcss-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        biome = {},

        -- web
        html = {
          filetypes = { "html", "templ" },
        },
        htmx = {
          filetypes = { "html", "templ" },
        },
        tailwindcss = {},
      })
    end,
  },
}
