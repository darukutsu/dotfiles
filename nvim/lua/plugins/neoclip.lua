return {
  "AckslD/nvim-neoclip.lua",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("neoclip").setup({
      on_select = {
        move_to_front = true,
        close_telescope = true,
      },
      on_paste = {
        set_reg = false,
        move_to_front = true,
        close_telescope = true,
      },
      keys = {
        telescope = {
          n = {
            custom = {},
          },
        },
      },
    })
  end,
}
