return {
  "chentoast/marks.nvim", -- mark hint on side
  event = "UIEnter",
  --lazy = false,
  opts = {
    default_mappings = false,
    refresh_interval = 250,
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    bookmark_0 = {
      sign = "⚑",
      virt_text = "bookmark0",
      annotate = true,
    },
    mappings = {
      toggle = "m,",
      preview = "m:",
      delete_buf = "dm",
      --delete_line = "dm-",
      --next = "]m",
      --prev = "[m",
      next = "m]",
      prev = "m[",

      -- I don't use this
      --annotate = "Ma",
      --set_bookmark0 = "M0",
      --set_bookmark1 = "M1",
      --set_bookmark2 = "M2",
      --set_bookmark3 = "M3",
      --set_bookmark4 = "M4",
      --set_bookmark5 = "M5",
      --set_bookmark6 = "M6",
      --set_bookmark7 = "M7",
      --set_bookmark8 = "M8",
      --set_bookmark9 = "M9",
      --delete_bookmark = "dM",
      --next_bookmark = "M]",
      --prev_bookmark = "M[",
    },
  },
}
