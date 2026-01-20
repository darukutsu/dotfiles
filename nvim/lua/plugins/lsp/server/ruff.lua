--local on_attach = function(client, bufnr)
--  if client.name == 'ruff_lsp' then
--    --client.server_capabilities.hoverProvider = true
--  end
--end

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
--vim.lsp.config("ruff_ls", {
vim.lsp.config("ruff", {
  --on_attach = on_attach,
  filetypes = { "python", "py", "py3" },

  settings = {
    configuration = {
      --lint = {
      --  enable = false,
      --},
      --format = {
      --  enable = false,
      --},
      organizeImports = true,
      fixAll = true,
    },
  },
  --init_options = {
  --  settings = {
  --    -- Any extra CLI arguments for `ruff` go here
  --    args = {
  --      "--select=ALL",
  --    },
  --    format = {
  --      args = {
  --        --"--config",
  --        --"indent-width = 2",
  --      },
  --    },
  --    showNotification = true,
  --    --organizeImports = true,
  --    source = {
  --      organizeImports = true,
  --      --fixAll = true,
  --    },
  --  },
  --commands = {
  --  RuffAutofix = {
  --    function()
  --      vim.lsp.buf.execute_command({
  --        command = "ruff.applyAutofix",
  --        arguments = {
  --          { uri = vim.uri_from_bufnr(0) },
  --        },
  --      })
  --    end,
  --    description = "Ruff: Fix all auto-fixable problems",
  --  },
  --  RuffOrganizeImports = {
  --    function()
  --      vim.lsp.buf.execute_command({
  --        command = "ruff.applyOrganizeImports",
  --        arguments = {
  --          { uri = vim.uri_from_bufnr(0) },
  --        },
  --      })
  --    end,
  --    description = "Ruff: Format imports",
  --  },
  --},
})
