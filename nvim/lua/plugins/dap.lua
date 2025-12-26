-- see for more configuration options:
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-codelldb-https-github-com-vadimcn-vscode-lldb
return {
  {
    "mfussenegger/nvim-dap",
    event = "CmdlineEnter",
    keys = function()
      return {
        { "<leader>dd", ":lua require('dap').continue()<cr>", desc = "continue" },
        { "<leader>dR", ":lua require('dap').restart()<cr>", desc = "restart" },
        { "<leader>dP", ":lua require('dap').pause()<cr>", desc = "pause" },
        { "<leader>dr", ":lua require('dap').repl.open()<cr>", desc = "repl open" },
        { "<leader>dt", ":lua require('dap').toggle_breakpoint()<cr>", desc = "toggle breakpoint" },
        { "<leader>dx", ":DapTerminate<CR>", desc = "terminate" },
        { "<leader>dl", ":lua require('dap').run_last()<cr>", desc = "run last" },
        { "<leader>do", ":lua require('dap').step_over()<cr>", desc = "step over" },
        { "<leader>di", ":lua require('dap').step_into()<cr>", desc = "step into" },
        { "<leader>dO", ":lua require('dap').step_out()<cr>", desc = "step out" },
        { "<leader>dh", ":lua require('dap.ui.widgets').hover()<cr>", desc = "ui hover" },
        { "<leader>dp", ":lua require('dap.ui.widgets').preview()<cr>", desc = "ui preview" },
        {
          "<leader>ds",
          ":lua require('dap.ui.widgets').widgets.centered_float(widgets.scopes)<cr>",
          desc = "ui widget float scopes",
        },
        {
          "<leader>df",
          ":lua require('dap.ui.widgets').widgets.centered_float(widgets.frames)<cr>",
          desc = "ui widget float frames",
        },
      }
    end,
    opts = {},
    config = function(_, opts)
      if vim.g.bigfile then
        return
      end

      local dap = require("dap")

      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
        name = "lldb",
      }

      dap.adapters.codelldb = {
        -- see if version older than 1.11.0 https://codeberg.org/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
        type = "executable",
        command = "codelldb",
      }

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
  {
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
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      highlight_changed_variables = true,
      --all_frames= false,
    },
  },
}
