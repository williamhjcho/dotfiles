return {
  single_file_support = false,
  settings = {
    complete_function_calls = true,
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = {
          {
            name = 'typescript-svelte-plugin',
            location = vim.fn.expand('$MASON/packages/svelte-language-server/node_modules/typescript-svelte-plugin'),
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
}
