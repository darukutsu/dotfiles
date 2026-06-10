-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff
-- for settings see https://docs.astral.sh/ruff/editors/settings
vim.lsp.config("ruff", {
  filetypes = { "python", "py", "py3" },

  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      fixAll = false,
      organizeImports = true,
      configuration = {
        lint = {
          ["extend-select"] = { "I" },
        },
        format = {
          -- this is not necessary for my unix setup, not sure if it works
          ["docstring-code-format"] = true,
          ["indent-style"] = "space",
          ["line-ending"] = "lf",
          ["quote-style"] = "double",
          ["skip-magic-trailing-comma"] = false,
        },
      },
    },
  },

  -- See vim.lsp.commands
  -- Note this is not replacement for vscode autocommands
  --commands = {
  --	{
  --	title = "Ruff: Fix all problems",
  --	command = "ruff check --fix",
  --	},
  --  RuffAutofix = {
  --    function()
  --      vim.lsp.buf.execute_command({
  --        command = "ruff check --fix",
  --        arguments = {
  --          { uri = vim.uri_from_bufnr(0) },
  --        },
  --      })
  --    end,
  --    description = "Ruff: Fix all problems",
  --  },
  --}
})
