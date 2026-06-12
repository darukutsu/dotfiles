return {
  {
    "folke/sidekick.nvim",
    cmd = "Sidekick",
    opts = {
      nes = { enabled = true },
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
        tools = {
          opencode = {
            env = {
              --OPENCODE_THEME = "system",
            },
          },
          --my_tool = {
          --  cmd = { "my-ai-cli", "--flag" },
          --  keys = {
          --    submit = { "<c-s>", function(t) t:send("\n") end, },
          --  },
          --},
        },
        prompts = {
          simplify = "Simplify {this}",
          audit = "Review {file} for security vulnerabilities",
          gitaudit = "Review this project for security vulnerabilities",
          gitsec = "Check this project if malicious in any way",
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
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>an",
        function()
          require("sidekick.nes").toggle()
        end,
        mode = { "n", "x" },
        desc = "Sidekick NES Toggle",
      },
      {
        "<leader>a?",
        function()
          require("sidekick.nes").have()
        end,
        mode = { "n", "x" },
        desc = "Sidekick NES Check",
      },
      {
        "<leader>a!",
        function()
          require("sidekick.nes").clear()
        end,
        mode = { "n", "x" },
        desc = "Sidekick NES Stop/Clear",
      },
      {
        "<leader>au",
        function()
          require("sidekick.nes").update()
        end,
        mode = { "n", "x" },
        desc = "Sidekick NES Update",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
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
        "<leader>ab",
        function()
          require("sidekick.cli").send({ msg = "{buffers}" })
        end,
        desc = "Send List of Buffers",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>ad",
        function()
          require("sidekick.cli").send({ msg = "{diagnostics}" })
        end,
        desc = "Send Buffer Diagnostics",
      },
      {
        "<leader>aD",
        function()
          require("sidekick.cli").send({ msg = "{diagnostics_all}" })
        end,
        desc = "Send Workspace Diagnostics",
      },

      -- Provider binds
      {
        "<leader>aO",
        function()
          require("sidekick.cli").toggle({ name = "opencode", focus = true })
        end,
        desc = "Sidekick Toggle Opencode",
      },
      {
        "<leader>aC",
        function()
          require("sidekick.cli").toggle({ name = "copilot", focus = true })
        end,
        desc = "Sidekick Toggle Copilot",
      },
      {
        "<leader>aA",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
}
