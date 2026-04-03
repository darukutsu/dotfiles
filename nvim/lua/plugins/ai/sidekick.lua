return {
  {
    "folke/sidekick.nvim",
    cmd = "Sidekick",
    opts = {
      nes = { enabled = false },
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
        --my_tool = {
        --  cmd = { "my-ai-cli", "--flag" },
        --  keys = {
        --    submit = { "<c-s>", function(t) t:send("\n") end, },
        --  },
        --},
        prompts = {
          simplify = "Simplify {this}",
          security = "Review {file} for security vulnerabilities",
          short = "Make {this} shorter if possible",
          --custom = function(ctx)
          --  return "Current file: " .. ctx.buf .. " at line " .. ctx.row
          --end,
        },
      },
    },
    keys = {
      -- NOTE:
      -- <c-z> leave ai to nvim buffer
      -- <c-q> normal mode cli
      -- <q> close ai, must be in normal mode
      {
        "<C-tab>",
        function()
          return require("sidekick").nes_jump_or_apply()
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function()
          require("sidekick.cli").select({
            --filter = { installed = true },
          })
        end,
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>al",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },

      -- Custom ai binds
      {
        "<leader>ao",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick Toggle Opencode",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").toggle({ name = "copilot", focus = true })
        end,
        desc = "Sidekick Toggle Copilot",
      },
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
}
