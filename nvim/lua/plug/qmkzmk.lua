local group = vim.api.nvim_create_augroup("QMK", {})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "40% ortho keymap",
  group = group,
  pattern = "*qmk/keymap.c",
  callback = function()
    require("qmk").setup({
      name = "LAYOUT_40ortho",
      auto_format_pattern = "*qmk/keymap.c",
      layout = {
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
      },
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "corne 6row keymap",
  group = group,
  pattern = "corne.keymap",
  callback = function()
    require("qmk").setup({
      variant = "zmk",
      name = "LAYOUT_corne6",
      auto_format_pattern = "corne.keymap",
      layout = {
        "x x x x x x _ _ _ x x x x x x",
        "x x x x x x _ _ _ x x x x x x",
        "x x x x x x _ _ _ x x x x x x",
        "_ _ _ _ x x x _ x x x _ _ _ _",
      },
    })
  end,
})

--vim.api.nvim_create_autocmd("BufEnter", {
--  desc = "unix60 keymap",
--  group = group,
--  pattern = "unix60.keymap",
--  callback = function()
--    require("qmk").setup({
--      variant = "zmk",
--      name = "LAYOUT_corne6",
--      auto_format_pattern = "*overlap/keymap.c",
--      layout = {
--        "x x x x x x _ _ _ x x x x x x",
--        "x x x x x x _ _ _ x x x x x x",
--        "x x x x x x _ _ _ x x x x x x",
--        "_ _ _ _ x x x _ x x x _ _ _ _",
--      },
--    })
--  end,
--})
