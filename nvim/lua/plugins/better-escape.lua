return {
  "max397574/better-escape.nvim",
  event = "VeryLazy",
  config = function()
    require("better_escape").setup({
      default_mappings = false,
      mappings = {
        t = {
          ["<esc>"] = {
            ["<esc>"] = "<C-\\><C-n>",
          },
        },
      },
    })
  end,
}
