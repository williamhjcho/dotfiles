require('conform').setup({
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    end

    return {
      timeout_ms = 500,
      lsp_format = 'fallback',
    }
  end,
  formatters_by_ft = {
    -- general
    lua = { 'stylua' },
    sh = { 'beautysh' },
    zsh = { 'beautysh' },
    terraform_fmt = { 'terraform' },
    toml = { 'taplo' },
    json = { 'biome' },
    jsonc = { 'biome' },
    -- terraform
    hcl = { 'packer_fmt' },
    terraform = { 'terraform_fmt' },
    tf = { 'terraform_fmt' },
    ['terraform-vars'] = { 'terraform_fmt' },
    -- go
    go = { 'goimports', 'gofumpt' },
    templ = { 'templ' }, -- go templ templates
    -- web/js/ts
    css = { 'biome' },
    javascript = { 'biome' },
    javascriptreact = { 'biome' },
    typescript = { 'biome' },
    typescriptreact = { 'biome' },
    svelte = { 'biome', lsp_format = 'first' },
    -- dart/flutter
    dart = { 'dart_format' },
    -- python
    python = {
      'ruff_fix', -- fix auto-fixable lint errors
      'ruff_format',
      'ruff_organize_imports',
    },
    -- clojure
    clojure = { lsp_format = 'fallback' },
  },
})
