return {
  "chrisgrieser/nvim-spider", -- advanced wordmotion
  --event = "UIEnter",
  -- lazy = false,
  dependencies = {
    -- utf8 support
    --"theHamsta/nvim_rocks",
    --event = "VeryLazy",
    --build = "pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
    --config = function()
    --  require("nvim_rocks").ensure_installed("luautf8")
    --end,
  },
  keys = function()
    return {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "o", "x" },
      },

      {
        "W",
        function()
          require("spider").motion("w", { subwordMovement = false })
        end,
        mode = { "n", "o", "x" },
      },
      {
        "B",
        function()
          require("spider").motion("b", { subwordMovement = false })
        end,
        mode = { "n", "o", "x" },
      },
      {
        "E",
        function()
          require("spider").motion("e", { subwordMovement = false })
        end,
        mode = { "n", "o", "x" },
      },
      --"func() require('spider').motion('e', { subwordMovement = false, skipInsignificantPunctuation=false })<CR>", {})
    }
  end,
  opts = {
    skipInsignificantPunctuation = true,
    consistentOperatorPending = true,
    subwordMovement = true,
    customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
  },
}
