return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    cmd = { 'Mason' },
    build = ':MasonUpdate',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', { desc = 'Mason' } },
    },
    opts_extended = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        -- general
        'lua-language-server', -- lua LSP
        'stylua',
        'beautysh', -- sh, zsh formatter
        -- 'shellcheck', -- sh linter
        -- 'hadolint', -- Docker lint
        'taplo', -- TOML LSP
        'yaml-language-server',
        'ruff', -- python formatter & linter
        'clojure-lsp', -- clojure LSP
        -- web/js/ts
        'biome', -- js/ts formatter & linter
        'typescript-language-server',
        'tailwindcss-language-server',
        'svelte-language-server',
        'tflint', -- terraform linter
        -- go
        'goimports', -- formatter
        'gofumpt', -- formatter
        'delve', -- dap
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      -- auto installing ensure_installed tools
      local mr = require('mason-registry')

      local notify = vim.schedule_wrap(function(msg, level)
        level = level or vim.log.levels.INFO
        vim.notify(msg, level, { title = 'mason-auto-install' })
      end)

      local function install_packages()
        for _, tool in ipairs(opts.ensure_installed) do
          if mr.has_package(tool) then
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_packages)
      else
        install_packages()
      end
    end,
  },
}
