vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.no_man_maps = 1

local aug = vim.api.nvim_create_augroup("BigFileDisable", {})
vim.api.nvim_create_autocmd("BufReadPre", {
  group = aug,
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.fn.expand("<afile>"))
    if ok and stats and stats.size > 100000 then
      vim.b.bigfile = true
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.wo.scrolloff = 999
    vim.wo.rnu = true
    vim.wo.nu = true
  end,
})
