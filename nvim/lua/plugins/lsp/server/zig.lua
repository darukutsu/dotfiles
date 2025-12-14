vim.lsp.config("zig", {
  settings = {
    zig = {
      zls = {
        warnStyle = {
          enabled = true,
        },
        highlightGlobalVarDeclarations = {
          enabled = true,
        },
      },
    },
  },
})
