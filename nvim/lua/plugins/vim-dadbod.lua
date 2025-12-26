local ft = { "sql", "mysql", "plsql" }

return {
  "kristijanhusak/vim-dadbod-ui",
  --event = "VeryLazy",
  ft = ft,
  keys = function()
    return {
      { "<leader>D", ":DBUIToggle<cr>", { desc = "dadbod toggle" } },
    }
  end,
  dependencies = {
    { "tpope/vim-dadbod", ft = ft, lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = ft, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
