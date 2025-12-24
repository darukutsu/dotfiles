-- This plugin is not really necessary however has nicer aesthetics than
-- what I was able achieve using baleia.
return {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      vim.keymap.set({ "n" }, "<Esc>", "<Plug>(KsbCloseOrQuitAll)", {})
      require("kitty-scrollback").setup({
        {
          keymaps_enabled = false,
          paste_window = {
            yank_register_enabled = false,
          },
        },
      })
    end,
  },
}
