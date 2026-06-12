return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  keys = function()
    return {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "smart-split resize left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "smart-split resize down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "smart-split resize up",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "smart-split resize right",
      },

      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "smart-split move cursor left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "smart-split move cursor down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "smart-split move cursor up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "smart-split move cursor right",
      },
      {
        "<C-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
        desc = "smart-split move cursor prev",
      },

      {
        "<C-A-h>",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "smart-split swap left",
      },
      {
        "<C-A-j>",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "smart-split swap down",
      },
      {
        "<C-A-k>",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "smart-split swap up",
      },
      {
        "<C-A-l>",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "smart-split swap right",
      },
      {
        "<leader>wh",
        ":vnew<cr>",
        desc = "newbuf left",
      },
      {
        "<leader>wj",
        ":rightbelow new<cr>",
        desc = "newbuf down",
      },
      {
        "<leader>wk",
        ":new<cr>",
        desc = "newbuf up",
      },
      {
        "<leader>wl",
        ":rightbelow vnew<cr>",
        desc = "newbuf right",
      },
    }
  end,
  opts = {
    ignored_filetypes = {},
    --multiplexer_integration = "zellij",
    --zellij_move_focus_or_tab = true,
  },
}
