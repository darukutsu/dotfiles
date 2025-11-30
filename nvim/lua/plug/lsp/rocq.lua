vim.cmd([[
  "let g:coqtail_coq_path = 'rocq'
  "let g:coqtail_coq_prog = 'rocq'
  let g:loaded_coqtail = 1
  let g:coqtail#supported = 0
]])

require("vsrocq").setup({
  lsp = {
    on_attach = function(client, bufnr)
      local map = vim.keymap.set
      map({ "n", "x", "o" }, "<leader>rn", ":VsRocq stepForward<cr>", { buffer = bufnr, desc = "Roqc step forward" })
      map({ "n", "x", "o" }, "<leader>rp", ":VsRocq stepBackward<cr>", { buffer = bufnr, desc = "Roqc step backward" })
      map(
        { "n", "x", "o" },
        "<leader>rb",
        ":VsRocq interpretToPoint<cr>",
        { buffer = bufnr, desc = "Roqc interpretToPoint" }
      )
      map(
        { "n", "x", "o" },
        "<leader>re",
        ":VsRocq interpretToEnd<cr>",
        { buffer = bufnr, desc = "Roqc interpretToEnd" }
      )
    end,
    --cmd = { "vsrocqtop" },
    filetypes = { "coq", "v" },
  },
})
