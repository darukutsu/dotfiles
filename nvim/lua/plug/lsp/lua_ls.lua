vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      format = {
        -- stylua good
        enable = false,
      },
    },
  },
})
