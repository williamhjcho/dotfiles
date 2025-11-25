return {
  -- lua/vim/nvim
  {
    mason = { 'stylua' },
    lsp = { 'lua_ls' },
    treesitter = { 'lua', 'luap', 'luadoc', 'vim', 'vimdoc' },
    formatters = {
      lua = { 'stylua' },
    },
  },
  -- git
  { treesitter = { 'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'diff' } },
  -- general
  {
    mason = { 'beautysh', 'shellcheck', 'pgformatter' },
    treesitter = { 'bash', 'markdown', 'markdown_inline', 'query', 'regex' },
    formatters = {
      sh = { 'beautysh' },
      zsh = { 'beautysh' },
    },
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
    formatters = {
      toml = { 'taplo' },
      json = { 'biome' },
      jsonc = { 'biome' },
      sql = { 'pg_format' },
    },
  },
  -- javascript/typescript & web general
  {
    mason = { 'vtsls', 'svelte-language-server', 'deno' },
    lsp = { 'vtsls', 'tailwindcss', 'biome', 'denols' },
    treesitter = { 'html', 'css', 'jsdoc', 'tsx', 'typescript', 'astro', 'svelte' },
    formatters = {
      css = { 'biome' },
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      svelte = { 'biome', lsp_format = 'first' },
    },
  },
  {
    mason = { 'svelte-language-server' },
    lsp = { 'svelte' },
  },
  -- go
  {
    lsp = { 'gopls' },
    treesitter = { 'go', 'gomod', 'gowork', 'gosum' },
    formatters = {
      go = { 'goimports', 'gofumpt' },
      templ = { 'templ' },
    },
  },
  -- python
  {
    mason = { 'basedpyright' },
    lsp = { 'ruff', 'basedpyright' },
    treesitter = { 'python' },
    formatters = {
      python = {
        'ruff_fix', -- fix auto-fixable lint errors
        'ruff_format',
        'ruff_organize_imports',
      },
    },
  },
  -- dart/flutter
  {
    treesitter = { 'dart' },
    formatters = {
      dart = { 'dart_format' },
    },
  },
  -- clojure
  {
    mason = { 'clojure-lsp' },
    lsp = { 'clojure_lsp' },
    treesitter = { 'clojure' },
    formatters = {
      clojure = { lsp_format = 'fallback' },
    },
  },
  -- terraform
  {
    mason = { 'tflint' },
    treesitter = { 'terraform', 'hcl' },
    formatters = {
      terraform_fmt = { 'terraform' },
      hcl = { 'packer_fmt' },
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
    },
  },
}
