return {
  "chrisgrieser/nvim-recorder",
  event = "UIEnter",
  --lazy = false,
  dependencies = "rcarriga/nvim-notify",
  opts = {
    slots = { "a", "b", "c", "d", "e", "f" },
    dynamicSlots = "rotate",
    editInBuffer = true,
    lessNotifications = true,
    clear = true,
  },
  config = function(_, opts)
    require("recorder").setup(opts)

    local lualineA = require("lualine").get_config().sections.lualine_a or {}
    table.insert(lualineA, { require("recorder").recordingStatus })
    table.insert(lualineA, { require("recorder").displaySlots })

    require("lualine").setup({
      sections = {
        lualine_a = lualineA,
      },
    })
  end,
}
