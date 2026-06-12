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
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- nes integration
    },
    cmd = "Copilot",
    event = "VeryLazy", -- so we can use it in any buffer even if can't edit
    keys = {
      { "<leader>Cp", ":Copilot panel toggle<cr>", desc = "toggle copilot panel" },
      { "<leader>Ct", ":Copilot toggle<cr>", desc = "copilot attach/detach" },
      { "<leader>Cs", ":Copilot status<cr>", desc = "copilot status" },
      -- TODO: some fzf menu
      --{ "<leader>Cm", ":Copilot status<cr>", desc = "copilot model select" },
      { "<leader>Ce", ":Copilot enable<cr>", desc = "copilot enable" },
      { "<leader>Cd", ":Copilot disable<cr>", desc = "copilot disable" },
      { "<leader>ae", toggle_copilot, desc = "copilot enable/disable" },
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
        },

        nes = {
          enabled = true,
          keymap = {
            accept = "<C-tab>",
            next = "<C-.>",
            prev = "<C-,>",
            dismiss = "<esc>",
          },
        },

        disable_limit_reached_message = true,
      })

      if not isCopilot then
        vim.cmd("Copilot disable")
      end
    end,
  },
}
