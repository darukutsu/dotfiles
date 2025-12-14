return {
  "duckdm/neowarrior.nvim",
  event = "CmdlineEnter",
  -- TODO: change to main when autocmd fixed
  branch = "develop",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "folke/noice.nvim",
  },
  keys = {
    { "<leader>t", ":NeoWarriorOpen<cr>", desc = "open taskwarrior" },
  },
  opts = {},
}
