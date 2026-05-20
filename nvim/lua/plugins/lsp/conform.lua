return {
  "stevearc/conform.nvim",
  lazy = false,
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      json = { "jq" },
      jsonc = { "jq" },
      markdown = { "mdsf" },
    },
    formatters = {
      jq = {
        prepend_args = { "--indent", "2" },
      },
    },
  },
}
