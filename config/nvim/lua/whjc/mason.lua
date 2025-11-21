require('mason').setup()

local ensure_installed = {
  'beautysh', -- sh, zsh formatter
  'shellcheck', -- sh linter
  'hadolint', -- Docker lint
  'clojure-lsp', -- clojure LSP
  'vtsls', -- js/ts LSP
  'svelte-language-server',
  'tflint', -- terraform linter
  'yaml-language-server', -- YAML linter
  'json-lsp', -- JSON lsp (used by schemastore)
}

-- auto installing ensure_installed tools
local mr = require('mason-registry')
local function install_packages()
  for _, tool in ipairs(ensure_installed) do
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
