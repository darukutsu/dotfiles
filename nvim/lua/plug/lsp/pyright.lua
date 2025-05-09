vim.lsp.config("pyright", {
  -- AUTOFORMATTING
  --on_attach = function(client, bufnr)
  --  if client.supports_method("textDocument/formatting") then
  --    vim.api.nvim_clear_autocmds({
  --      group = augroup,
  --      buffer = bufrn,
  --    })
  --    vim.api.nvim_create_autocmd("BufWritePre", {
  --      group = augroup,
  --      buffer = bufrn,
  --      callback = function()
  --        vim.lsp.buf.format({ bufnr = bufnr })
  --      end,
  --    })
  --  end
  --end,
  ----capabilities = capabilities,
  --filetypes = { "python" },
})
