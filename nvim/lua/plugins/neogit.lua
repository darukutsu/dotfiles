-- TODO: setup and use this finally
return {
  "NeogitOrg/neogit", -- git integration
  cmd = "Neogit",
  --event = "CmdlineEnter",
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
      --snacks = false,
      --mini_pick = false,
    },
    graph_style = "kitty",
    --process_spinner = true,
    disable_line_numbers = false,
    disable_relative_line_numbers = false,
  },
}
