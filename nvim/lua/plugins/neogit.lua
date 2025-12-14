return {
  "NeogitOrg/neogit", -- git integration
  event = "CmdlineEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "sindrets/diffview.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>G", ":Neogit<cr>", desc = "neogit" },
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
}
