return {
  "luukvbaal/nnn.nvim",
  --event = "VeryLazy",
  cmd = { "NnnExplorer", "NnnPicker" },
  keys = function()
    return {
      { "<leader><leader>n", ":NnnExplorer<cr>", { desc = "nnn explorer" } },
    }
  end,
  opts = {
    explorer = {
      cmd = "nnn",
      width = 30,
    },
  },
}
