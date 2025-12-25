return {
  "folke/snacks.nvim", -- this has complete workflow, i just need working vim.ui.select
  priority = 1000,
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    animate = {},
    bigfile = {
      enabled = true,
      notify = true,
      size = 1024 * 300, -- KB
      line_length = 200,
    },
    dashboard = {
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    dim = {},
    --git = {},
    gitbrowse = {},
    indent = {},
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
    statuscolumn = {},
    --scroll = {
    --  animate = {
    --    duration = { total = 500 },
    --    easing = "linear",
    --  },
    --  animate_repeat = {
    --    delay = 10,
    --    duration = { total = 500 },
    --    easing = "linear",
    --  },
    --},
    terminal = {},
    toggle = {
      --which_key = false,
    },
    words = {},
    --quickfile = {},
  },
}
