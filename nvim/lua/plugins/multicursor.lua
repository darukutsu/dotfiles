return {
  "jake-stewart/multicursor.nvim",
  --event = "UIEnter",
  --branch = "1.0",
  keys = function()
    return {
      -- Add or skip cursor above/below the main cursor.
      {
        "<up>",
        function()
          require("multicursor-nvim").lineAddCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<down>",
        function()
          require("multicursor-nvim").lineAddCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader><up>",
        function()
          require("multicursor-nvim").lineSkipCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader><down>",
        function()
          require("multicursor-nvim").lineSkipCursor(1)
        end,
        mode = { "n", "x" },
      },

      -- Add or skip adding a new cursor by matching word/selection
      -- this is somewhat useless since we can use regex to replace
      {
        "<leader>mn",
        function()
          require("multicursor-nvim").matchAddCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader>mp",
        function()
          require("multicursor-nvim").matchAddCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader>mN",
        function()
          require("multicursor-nvim").matchAddCursor(-1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader>ms",
        function()
          require("multicursor-nvim").matchSkipCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader>mS",
        function()
          require("multicursor-nvim").matchSkipCursor(-1)
        end,
        mode = { "n", "x" },
      },

      -- Add or skip adding a new cursor by matching diagnostics.
      {
        "<leader>m]",
        function()
          require("multicursor-nvim").diagnosticAddCursor(1)
        end,
        mode = { "n", "x" },
      },
      {
        "<leader>m[",
        function()
          require("multicursor-nvim").diagnosticAddCursor(-1)
        end,
        mode = { "n", "x" },
      },

      -- Add and remove cursors with control + left click.
      {
        "<c-leftmouse>",
        function()
          require("multicursor-nvim").handleMouse()
        end,
      },
      {
        "<c-leftdrag>",
        function()
          require("multicursor-nvim").handleMouseDrag()
        end,
      },
      {
        "<c-leftrelease>",
        function()
          require("multicursor-nvim").handleMouseRelease()
        end,
      },

      -- Disable and enable cursors(pause).
      {
        "<c-q>",
        function()
          require("multicursor-nvim").toggleCursor()
        end,
        mode = { "n", "x" },
      },

      -- Pressing `gaip` will add a cursor on each line of a paragraph.
      -- Can also be used to add cursor for each line of visual selection.
      {
        "ga",
        function()
          require("multicursor-nvim").addCursorOperator()
        end,
        mode = { "n", "x" },
      },
    }
  end,
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<leader><del>", mc.deleteCursor)

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>ma", mc.alignCursors)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
