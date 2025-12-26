return {
  "rcarriga/nvim-dap-ui",
  --event = "VeryLazy",
  --lazy = false,
  keys = function()
    return {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "toggle dapui",
      },
    }
  end,
  opts = {
    ---- DEFAULTS :h dapui.setup()
    --mappings = {
    --  edit = "e",
    --  expand = { "<CR>", "<2-LeftMouse>" },
    --  open = "o",
    --  remove = "d",
    --  repl = "r",
    --  toggle = "t"
    --},
  },
  dependencies = { { "mfussenegger/nvim-dap" }, { "nvim-neotest/nvim-nio" } },
  config = function(_, opts)
    -- auto close, open window on events
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
