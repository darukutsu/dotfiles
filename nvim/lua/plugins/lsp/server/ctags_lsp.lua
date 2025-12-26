vim.lsp.config("ctags_lsp", {
  cmd = { "ctags-lsp" },
  filetypes = { "ruby", "python" },
  root_dir = vim.uv.cwd(),
})
-- hmm...
--vim.lsp.enable("ctags_lsp")
