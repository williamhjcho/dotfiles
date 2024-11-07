return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "json5",
        "tsx",
        "typescript",
      })
      opts.auto_install = true
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "biome",
        "typescript-language-server",
        "tailwindcss-language-server",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        ---- tsserver managed by extra plugin
        -- tsserver = {},
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
