return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    cmd = { 'Mason' },
    build = ':MasonUpdate',
    opts_extended = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        -- general
        'beautysh', -- sh, zsh formatter
        'shellcheck', -- sh linter
        'hadolint', -- Docker lint
        'clojure-lsp', -- clojure LSP
        'vtsls', -- js/ts LSP
        'svelte-language-server',
        'tflint', -- terraform linter
        'yaml-language-server', -- YAML linter
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      -- auto installing ensure_installed tools
      local mr = require('mason-registry')

      -- local notify = vim.schedule_wrap(function(msg, level)
      --   level = level or vim.log.levels.INFO
      --   vim.notify(msg, level, { title = 'mason-auto-install' })
      -- end)

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
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
  },
}
