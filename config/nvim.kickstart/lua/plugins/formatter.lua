return {
  {
    'stevearc/conform.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
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
        javascript = { 'biome' },
        javascriptreact = { 'biome' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        -- dart/flutter
        dart = { 'dart_format' },
        -- python
        python = { 'ruff' },
      },
    },
  },
}
