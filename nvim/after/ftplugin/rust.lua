vim.keymap.set("n", "<leader>ra", function()
  vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rc", function()
  vim.cmd.RustLsp("openCargo")
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rh", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rm", function()
  vim.cmd.RustLsp("parentModule")
end, { silent = true, buffer = bufnr })

vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp({ "hover", "range" })
end, { silent = true, buffer = bufnr })
