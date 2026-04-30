return {
  "denialofsandwich/sudo.nvim",
  event = "VeryLazy",
  cmd = { "SudoRead", "SudoWrite", "SudoEdit" },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
