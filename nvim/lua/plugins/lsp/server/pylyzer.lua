local util = require("lspconfig.util")

vim.lsp.config("pylyzer", {
  root_dir = util.root_pattern("pyproject.toml", "pyrightconfig.json", "pylyzer.toml"),
  settings = {
    Python = {
      diagnostics = {
        -- Get the language server to recognize the `config` global
        globals = { "config" },
      },
    },
  },
})
