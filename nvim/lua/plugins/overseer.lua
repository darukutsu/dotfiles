-- TODO: figure out workflow then setup
return {
  "stevearc/overseer.nvim", -- task runner, like shell, good for dap, works only in codebases
  event = "VeryLazy",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  keys = function()
    return {
      { "<leader>O", ":OverseerRun<cr>", { desc = "Overseer run command" } },
    }
  end,
  opts = {},
}
