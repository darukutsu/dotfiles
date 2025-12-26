-- TODO: finish config after start heavily using it
return {
  "nvim-neotest/neotest",
  --event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = function()
    return {
      {
        "<leader>nr",
        function()
          require("neotest").run.run()
        end,
        desc = "neotest run",
      },
      {
        "<leader>ns",
        function()
          require("neotest").run.stop()
        end,
        desc = "neotest run stop",
      },
      {
        "<leader>na",
        function()
          require("neotest").run.attach()
        end,
        desc = "neotest attach",
      },
    }
  end,
  opts = {
    floating = {
      border = "bold",
    },
    summary = {
      enabled = true,
      animated = true,
    },
  },
  --config = function (_, opts)
  --end
}
