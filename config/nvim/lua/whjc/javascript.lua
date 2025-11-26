-- scripts to fix issues with javascript configurations/servers

-- special conflicts for vtsls & denols
if vim.lsp.config.denols and vim.lsp.config.vtsls then
  local resolve = function(server)
    local markers, root_dir = vim.lsp.config[server].root_markers, vim.lsp.config[server].root_dir
    vim.lsp.config(server, {
      root_dir = function(bufnr, on_dir)
        local is_deno = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' }) ~= nil
        if is_deno == (server == 'denols') then
          if root_dir then
            return root_dir(bufnr, on_dir)
          elseif type(markers) == 'table' then
            local root = vim.fs.root(bufnr, markers)
            return root and on_dir(root)
          end
        end
      end,
    })
  end
  resolve('denols')
  resolve('vtsls')
end

-- denols workaround to fix "go to definition"
-- https://github.com/neovim/neovim/issues/30908#issuecomment-2657220629
local function virtual_text_document(params)
  local bufnr = params.buf
  local actual_path = params.match:sub(1)

  local clients = vim.lsp.get_clients({ name = 'denols' })
  if #clients == 0 then
    return
  end

  local client = clients[1]
  local method = 'deno/virtualTextDocument'
  local req_params = { textDocument = { uri = actual_path } }
  local response = client.request_sync(method, req_params, 2000, 0)
  if not response or type(response.result) ~= 'string' then
    return
  end

  local lines = vim.split(response.result, '\n')
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  vim.api.nvim_set_option_value('readonly', true, { buf = bufnr })
  vim.api.nvim_set_option_value('modified', false, { buf = bufnr })
  vim.api.nvim_set_option_value('modifiable', false, { buf = bufnr })
  vim.api.nvim_buf_set_name(bufnr, actual_path)
  vim.lsp.buf_attach_client(bufnr, client.id)

  local filetype = 'typescript'
  if actual_path:sub(-3) == '.md' then
    filetype = 'markdown'
  end
  vim.api.nvim_set_option_value('filetype', filetype, { buf = bufnr })
end

vim.api.nvim_create_autocmd({ 'BufReadCmd' }, {
  pattern = { 'deno:/*' },
  callback = virtual_text_document,
})
