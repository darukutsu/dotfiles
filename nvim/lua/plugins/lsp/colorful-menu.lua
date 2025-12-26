return {
  "xzbdmw/colorful-menu.nvim",
  --event = "VeryLazy",
  config = function()
    require("colorful-menu").setup({
      ls = {
        --fallback = false,
        --fallback_extra_info_hl = "@comment",
      },
      --fallback_highlight = "@variable",
      --max_width = 60,
    })
  end,
}
