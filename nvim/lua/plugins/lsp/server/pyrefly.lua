local util = require("lspconfig.util")

vim.lsp.config("pyrefly", {
  root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),
})
