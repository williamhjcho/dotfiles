return {
  settings = {
    pyright = {
      -- handled by ruff
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- handled by ruff
        ignore = { '*' },
      },
    },
  },
}
