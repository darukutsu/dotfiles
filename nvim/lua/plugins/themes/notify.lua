return {
  "rcarriga/nvim-notify",
  event = "UIEnter",
  --lazy = false,
  init = function()
    vim.notify = require("notify")
    -- overwrite certain messages
    require("custom.suppress-errors")
  end,
  opts = {
    render = "wrapped-compact",
    stages = "slide",
    level = "INFO",
    fps = 30,
    timeout = 4000,
  },
}
