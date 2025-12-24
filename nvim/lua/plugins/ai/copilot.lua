local isCopilot = false
local function toggle_copilot()
  if isCopilot then
    isCopilot = false
    vim.cmd(":Copilot disable")
  else
    isCopilot = true
    vim.cmd(":Copilot enable")
  end
end

return {
  --{
  --  "github/copilot.vim",
  --  lazy = false,
  --  config = function() end,
  --},
  --{
  --  "copilotlsp-nvim/copilot-lsp",
  --  --lazy = false,
  --  --event = "InsertEnter",
  --  init = function()
  --    vim.g.copilot_nes_debounce = 500
  --    vim.lsp.enable("copilot_ls")
  --    --vim.keymap.set("n", "<tab>", function()
  --    --  local bufnr = vim.api.nvim_get_current_buf()
  --    --  local state = vim.b[bufnr].nes_state
  --    --  if state then
  --    --    -- Try to jump to the start of the suggestion edit.
  --    --    -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
  --    --    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
  --    --      or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
  --    --    return nil
  --    --  else
  --    --    -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
  --    --    return "<C-i>"
  --    --  end
  --    --end, { desc = "Accept Copilot NES suggestion", expr = true })
  --  end,
  --  opts = {
  --    nes = {
  --      move_count_threshold = 3,
  --    },
  --  },
  --},
  {
    "zbirenbaum/copilot.lua",
    --lazy = false,
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- nes integration
      -- init = function()
      --   vim.g.copilot_nes_debounce = 500
      -- end,
      -- opts = {
      --   nes = {
      --     move_count_threshold = 3,
      --   },
      -- },
    },
    cmd = "Copilot",
    event = { "InsertEnter", "CmdlineEnter" },
    --event = "VeryLazy",
    keys = {
      { "<leader>CC", ":Copilot panel toggle<cr>", desc = "toggle copilot panel" },
      { "<leader>Cp", ":Copilot panel toggle<cr>", desc = "toggle copilot panel" },
      { "<leader>Ct", ":Copilot toggle<cr>", desc = "copilot attach/detach" },
      { "<leader>Cs", ":Copilot status<cr>", desc = "copilot status" },
      --{ "<leader>Ca", ":Copilot attach<cr>", desc = "toggle copilot" },
      --{ "<leader>Cd", ":Copilot detach<cr>", desc = "toggle copilot" },
      { "<leader>Ce", ":Copilot enable<cr>", desc = "copilot enable" },
      { "<leader>Cd", ":Copilot disable<cr>", desc = "copilot disable" },
      { "<leader>at", toggle_copilot, desc = "copilot enable/disable" },
      -- copilot implement rest of keybinds
    },
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          --auto_refresh = true,
          layout = {
            position = "bottom",
            ratio = 0.3,
          },
        },

        suggestion = {
          enabled = false,
          keymap = {
            accept = "<C-l>",
            --accept_word = false,
            --accept_line = false,
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<C-/>",
          },
        },

        -- experimental
        --nes = {
        --  enabled = true,
        --  keymap = {
        --    --accept = "<C-l>",
        --    accept_and_goto = "<C-l>",
        --    accept_word = false,
        --    accept_line = false,
        --    next = "<C-]>",
        --    prev = "<C-[>",
        --    dismiss = "<esc>",
        --  },
        --},

        disable_limit_reached_message = true,
      })
      if not isCopilot then
        vim.cmd("Copilot disable")
      end
    end,
  },
}
