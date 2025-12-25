return {
  "lewis6991/gitsigns.nvim", -- git time stamps
  event = "VeryLazy",
  keys = {
    { "<leader>gB", ":Gitsigns blame<cr>", desc = "gitsigns blame" },
    { "<leader>gl", ":Gitsigns blame_line<cr>", desc = "gitsigns blame line" },
    { "<leader>gL", ":Gitsigns toggle_current_line_blame<cr>", desc = "gitsigns toggle blame line" },
    { "<leader>gh", ":Gitsigns preview_hunk<cr>", desc = "gitsigns preview_hunk" },
    { "<leader>gn", ":Gitsigns next_hunk<cr>", desc = "gitsigns next_hunk" },
    { "<leader>gp", ":Gitsigns prev_hunk<cr>", desc = "gitsigns prev_hunk" },
    { "<leader>g]", ":Gitsigns next_hunk<cr>", desc = "gitsigns next_hunk" },
    { "<leader>g[", ":Gitsigns prev_hunk<cr>", desc = "gitsigns prev_hunk" },
  },
  opts = {
    signs = {
      add = { show_count = true },
      change = { show_count = true },
      delete = { show_count = true },
      topdelete = { show_count = true },
      changedelete = { show_count = true },
    },
    --count_chars = {
    --  [1]   = '₁',
    --  [2]   = '₂',
    --  [3]   = '₃',
    --  [4]   = '₄',
    --  [5]   = '₅',
    --  [6]   = '₆',
    --  [7]   = '₇',
    --  [8]   = '₈',
    --  [9]   = '₉',
    --  ['+'] = '',
    --},
    current_line_blame_opts = {
      delay = 400,
    },
  },
}
