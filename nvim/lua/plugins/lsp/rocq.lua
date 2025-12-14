-- for school purpose only
return {
  --event = "VeryLazy",
  ft = { "coq", "v" },
  "tomtomjhj/vsrocq.nvim",
  --"simon-dima/vsrocq.nvim",
  dependencies = {
    { "whonore/Coqtail" },
  },
  init = function()
    vim.cmd([[
      "let g:coqtail_coq_path = 'rocq'
      "let g:coqtail_coq_prog = 'rocq'
      let g:loaded_coqtail = 1
      let g:coqtail#supported = 0
    ]])
  end,
  opts = {
    vsrocq = {
      memory = { limit = 2 },
      goals = {
        diff = { mode = "on" },
        messages = { full = true },
      },
      completion = { enable = true },
      diagnostics = { full = true },
      proof = { mode = "Continuous" },
    },
    lsp = {
      on_attach = function(client, bufnr)
        local map = vim.keymap.set
        local rocqMode = "Continuous"

        map({ "n" }, "<leader>rr", function()
          if rocqMode == "Continuous" then
            rocqMode = "Manual"
            vim.cmd("VsRocq manual")
          else
            rocqMode = "Continuous"
            vim.cmd("VsRocq continuous")
          end
        end, { desc = "toggle between Rocq modes" })
        map({ "n", "x", "o" }, "<leader>rn", ":VsRocq stepForward<cr>", { buffer = bufnr, desc = "Roqc step forward" })
        map(
          { "n", "x", "o" },
          "<leader>rp",
          ":VsRocq stepBackward<cr>",
          { buffer = bufnr, desc = "Roqc step backward" }
        )
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
      cmd = {
        --"env",
        --"COQLIB=/usr/lib/ocaml/coq",
        --"COQCORELIB=/usr/lib/ocaml/rocq-runtime",
        --"OCAMLFIND=ocamlfind",
        "vsrocqtop",
      },
      filetypes = { "coq", "v" },
    },
  },
  --config = function() end,
}
