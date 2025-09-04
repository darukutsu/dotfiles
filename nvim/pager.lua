vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.wo.scrolloff = 999
    vim.wo.rnu = true
    vim.wo.nu = true
    vim.g.no_man_maps = 1
  end,
})
