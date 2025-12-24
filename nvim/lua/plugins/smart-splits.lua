return {
  "mrjones2014/smart-splits.nvim",
  --event = "VeryLazy",
  -- lazy = false,
  keys = function()
    return {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
      },

      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
      },
      {
        "<C-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
      },

      {
        "<leader>wh",
        function()
          require("smart-splits").swap_buf_left()
        end,
      },
      {
        "<leader>wj",
        function()
          require("smart-splits").swap_buf_down()
        end,
      },
      {
        "<leader>wk",
        function()
          require("smart-splits").swap_buf_up()
        end,
      },
      {
        "<leader>wl",
        function()
          require("smart-splits").swap_buf_right()
        end,
      },
    }
  end,
  opts = {
    ignored_filetypes = {},
    --multiplexer_integration = "zellij",
    --zellij_move_focus_or_tab = true,
  },
}
