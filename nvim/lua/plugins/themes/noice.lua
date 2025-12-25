return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = {
      --enabled = false,
      view = "cmdline",
      format = {
        cmdline = { icon = ">:" },
        search_down = { icon = "/:" },
        search_up = { icon = "?:" },
        filter = { icon = "$" },
        lua = { icon = "lua:" },
        help = { icon = "help:" },
      },
    },
    messages = {
      view = "virtualtext",
    },
    lsp = {
      --enabled = false,
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    ---@type NoicePresets
    presets = {
      bottom_search = true,
      command_palette = true,
      --long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  --config = function()
  --end,
}
