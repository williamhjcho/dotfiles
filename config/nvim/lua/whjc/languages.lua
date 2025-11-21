return {
  -- lua
  { lsp = { 'lua_ls' } },
  -- sh/zsh
  { mason = { 'beautysh', 'shellcheck' } },
  -- Docker
  { mason = { 'hadolint' } },
  -- JSON/YAML/TOML
  {
    mason = { 'json-lsp', 'yaml-language-server' },
    lsp = { 'jsonls', 'yamlls', 'taplo' },
  },
  -- javascript/typescript & web general
  {
    mason = { 'vtsls', 'svelte-language-server' },
    lsp = { 'vtsls', 'tailwindcss', 'biome' },
  },
  {
    mason = { 'svelte-language-server' },
    lsp = { 'svelte' },
  },
  -- go
  { lsp = { 'gopls' } },
  -- python
  {
    mason = { 'basedpyright' },
    lsp = { 'ruff', 'basedpyright' },
  },
  -- clojure
  {
    mason = { 'clojure-lsp' },
    lsp = { 'clojure_lsp' },
  },
  -- terraform
  { mason = { 'tflint' } },
}
