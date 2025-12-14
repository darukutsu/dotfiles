return {
  "folke/snacks.nvim", -- this has complete workflow, i just need working vim.ui.select
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    words = {},
    toggle = {},
    statuscolumn = {},
    --scroll = {},
    dim = {},
    indent = {},
    bigfile = {
      enabled = true,
      size = 1024 * 200, -- 200KB
    },
    --quickfile = {},
    animate = {},
    --git = {},
    gitbrowse = {},
    input = {
      win = {
        position = "bottom",
        width = 1.0,
        height = 2,
      },
    },
    picker = {
      enabled = true,
      ui_select = true,
    },
  },
}
