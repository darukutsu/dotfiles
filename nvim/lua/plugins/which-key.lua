return {
  "folke/which-key.nvim", -- key help floating while typing
  event = "UIEnter",
  --lazy = false,
  opts = {
    preset = "helix",
    expand = function(node)
      return not node.desc -- expand all nodes without a description
    end,
    win = {
      border = "bold",
      --  bo = {},
      --  wo = {},
    },
  },
}
