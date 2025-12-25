return {
  "akinsho/toggleterm.nvim",
  --event = "VeryLazy",
  cmd = "ToggleTerm",
  version = "*",
  keys = function()
    return {
      -- use numbers to create new in direction
      { "<leader>tt", ":ToggleTerm<cr>", desc = "toggleterm" },
      { "<leader>tl", ":ToggleTerm direction=vertical<cr>", desc = "toggleterm right" },
      { "<leader>tj", ":ToggleTerm size=40 direction=horizontal<cr>", desc = "toggleterm down" },
      { "<leader>ta", ":ToggleTermToggleAll<cr>", desc = "toggleterm all" },
    }
  end,
  opts = {
    shade_terminals = false,
    --persist_size = false,
  },
}
