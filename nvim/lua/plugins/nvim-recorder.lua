return {
  "chrisgrieser/nvim-recorder",
  --event = "UIEnter",
  --lazy = false,
  dependencies = "rcarriga/nvim-notify",
  keys = {
    { "q", desc = " Start Recording Macro" },
    { "Q", desc = " Play Recording Macro" },
  },
  opts = {
    slots = { "a", "b", "c", "d", "e", "f" },
    dynamicSlots = "rotate",
    editInBuffer = true,
    logLevel = vim.log.levels.OFF,
    lessNotifications = true,
    clear = true,
    --mapping = {
    --startStopRecording = "q",
    --playMacro = "Q",
    --switchSlot = "<C-q>",
    --editMacro = "cq",
    --deleteAllMacros = "dq",
    --yankMacro = "yq",
    ---- ⚠️ this should be a string you don't use in insert mode during a macro
    --addBreakPoint = "##",
    --},
  },
  config = function(_, opts)
    --vim.keymap.set("n", "q", "<Nop>")
    require("recorder").setup(opts)

    local oklua, lualine = pcall(require, "lualine")
    if oklua then
      local lualineA = lualine.get_config().sections.lualine_a or {}
      table.insert(lualineA, { require("recorder").recordingStatus })
      table.insert(lualineA, { require("recorder").displaySlots })

      require("lualine").setup({
        sections = {
          lualine_a = lualineA,
        },
      })
    end
  end,
}
