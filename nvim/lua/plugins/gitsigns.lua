return {
  "lewis6991/gitsigns.nvim", -- git time stamps
  event = "CmdlineEnter",
  keys = {
    { "<leader>gb", ":Gitsigns blame<cr>" },
    { "<leader>gl", ":Gitsigns blame_line<cr>" },
    { "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>" },
    { "<leader>gh", ":Gitsigns preview_hunk<cr>" },
    { "<leader>gn", ":Gitsigns next_hunk<cr>" },
    { "<leader>gp", ":Gitsigns prev_hunk<cr>" },
    { "<leader>g]", ":Gitsigns next_hunk<cr>" },
    { "<leader>g[", ":Gitsigns prev_hunk<cr>" },
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
