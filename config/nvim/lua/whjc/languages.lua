return {
  -- lua/vim/nvim
  {
    lsp = { 'lua_ls' },
    treesitter = { 'lua', 'luap', 'luadoc', 'vim', 'vimdoc' },
  },
  -- git
  { treesitter = { 'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'diff' } },
  -- general
  {
    mason = { 'beautysh', 'shellcheck', 'pgformatter' },
    treesitter = { 'bash', 'markdown', 'markdown_inline', 'query', 'regex' },
  },
  -- Docker
  { mason = { 'hadolint' } },
  -- JSON/YAML/TOML
  {
    mason = { 'json-lsp', 'yaml-language-server' },
    lsp = { 'jsonls', 'yamlls', 'taplo' },
    treesitter = {
      'toml',
      'xml',
      'yaml',
      'json',
      -- 'jsonc', -- 403 issue
      'json5',
    },
  },
  -- javascript/typescript & web general
  {
    mason = { 'vtsls', 'svelte-language-server' },
    lsp = { 'vtsls', 'tailwindcss', 'biome' },
    treesitter = { 'html', 'css', 'jsdoc', 'tsx', 'typescript', 'astro', 'svelte' },
  },
  {
    mason = { 'svelte-language-server' },
    lsp = { 'svelte' },
  },
  -- go
  {
    lsp = { 'gopls' },
    treesitter = { 'go', 'gomod', 'gowork', 'gosum' },
  },
  -- python
  {
    mason = { 'basedpyright' },
    lsp = { 'ruff', 'basedpyright' },
    treesitter = { 'python' },
  },
  -- dart/flutter
  {
    treesitter = { 'dart' },
  },
  -- clojure
  {
    mason = { 'clojure-lsp' },
    lsp = { 'clojure_lsp' },
    treesitter = { 'clojure' },
  },
  -- terraform
  {
    mason = { 'tflint' },
    treesitter = { 'terraform', 'hcl' },
  },
}
