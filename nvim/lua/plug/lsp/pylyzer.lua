vim.lsp.config("pylyrizer", {
  settings = {
    Python = {
      diagnostics = {
        -- Get the language server to recognize the `` global
        globals = { "config" },
      },
    },
  },
})
