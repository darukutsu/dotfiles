return { -- debug ui
  "rcarriga/nvim-dap-ui",
  event = "UIEnter",
  --lazy = false,
  dependencies = { { "folke/lazydev.nvim" }, { "mfussenegger/nvim-dap" }, { "nvim-neotest/nvim-nio" } },
  config = function()
    -- auto close, open window on events
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    require("lazydev").setup({
      library = { "nvim-dap-ui" },
    })
  end,
}
