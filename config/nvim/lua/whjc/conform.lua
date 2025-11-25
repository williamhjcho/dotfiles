-- stylua: ignore
local formatters = vim
  .iter(require('whjc.languages'))
  :map(function(i) return i.formatters end)
  :filter(function(i) return i end)
  :fold({}, function(acc, formatters)
    return vim.tbl_extend('force', acc, formatters)
  end)

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
  formatters_by_ft = formatters,
})
