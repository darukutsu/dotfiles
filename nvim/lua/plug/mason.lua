-- :Mason shows below windows unlike :Lazy which shows above all even telescope
require("mason").setup({
  ui = {
    border = "none",
    --width = 1,
    height = 0.8,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },

    keymaps = {
      -- disable this until Telescope stops destroying Mason in dynamic_ivy(), or use snacks
      apply_language_filter = "/",
    },
    --install_root_dir=,
    --PATH=,
    --log_level=,
    --max_concurent_installers=,
    --registries=,
    --providers=,
    --github=,
    --pip=,
  },
})

-- Trying lsp-format disable until then
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local function autoformat_quit(client, bufnr)
  if vim.b[bufnr].bigfile then
    return
  end
  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        --vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

--https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
-- lsphandlers were disabled in nvim0.11+ use vim.lsp.config() instead
require("plug/lsp/lua_ls")
--  require("plug/lsp/pyright")
--  require("plug/lsp/pylyzer")
require("plug/lsp/ruff")
require("plug/lsp/zig")
require("plug/lsp/jdtls")
require("plug/lsp/clangd")
--  require("plug/lsp/matlab")
require("plug/lsp/ltex")
--require("plug/lsp/kotlin")

require("mason-lspconfig").setup({
  ensure_installed = {
    -- LSP
    "arduino_language_server",
    "ast_grep",
    "bashls",
    "biome",
    --"circleciyamllanguageserver", -- determine name
    "clangd",
    "dockerls",
    "gh_actions_ls",
    "gitlab_ci_ls",
    "gopls",
    "gradle_ls",
    "harper_ls",
    "html",
    "intelephense",
    "kotlin_lsp",
    "jdtls",
    "jsonls",
    "lemminx",
    "ltex",
    --"lua-language-server", -- shows errors
    "mesonlsp",
    "ruff",
    "rust_analyzer",
    "sqlls",
    "texlab",
    "yamlls",
    "zls",
  },
  automatic_installation = false,
  automatic_enable = true,
})

local dap_handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("mason-nvim-dap").default_setup(server_name)
  end,

  --["gopls"] = function(server_name)
  --  server_name.capabilities = vim.tbl_extend("force", vim.lsp.protocol.make_client_capabilities(), {
  --    textDocument = {
  --      rangeFormatting = {
  --        dynamicRegistration = true,
  --        rangesSupport = true,
  --      },
  --    },
  --  })
  --end,
  --["codelldb"] = function(server_name)
  --  server_name.adapters = {
  --    type = 'server',
  --    port = "${port}",
  --    executable = {
  --      -- CHANGE THIS to your path!
  --      command = '/usr/bin/codelldb',
  --      args = { "--port", "${port}" },

  --      -- On windows you may have to uncomment this:
  --      -- detached = false,
  --    },
  --  }
  --end,
}

require("mason-nvim-dap").setup({
  ensure_installed = {
    "codelldb",
    "delve",
    "java-debug-adapter",
    "java-test",
  },
  automatic_installation = false,
  handlers = dap_handlers,
})

local mason_null = require("mason-null-ls")
mason_null.setup({
  ensure_installed = {
    -- Linter
    "actionlint",
    "codespell",
    "detekt",
    "ktlint",
    "markdownlint",
    -- Formatter
    "asmfmt",
    "bibtex_tidy",
    "cbfmt",
    "clang_format",
    "lua-language-server",
    "isort",
    "jq",
    "latexindent",
    "phpcsfixer",
    "prettier",
    "shfmt",
    "sqlfmt",
    "stylua",
  },

  automatic_installation = false,
  --methods = {
  --  diagnostics = false,
  --  formatting = true,
  --  code_actions = false,
  --  completion = false,
  --  hover = false,
  --},

  --handlers = null_handlers,

  -- implicit automatic setup
  handlers = {},
})

--https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
--https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
--
--if unsupported when installing new check this
--https://github.com/nvimtools/none-ls.nvim/discussions/81
local null_ls = require("null-ls")
--local null_handlers = {
--  ["shfmt"] = function(source_name, methods)
--    null_ls.register(null_ls.builtins.formatting.shfmt.with({
--      extra_args = { "-i", "2" },
--    }))
--  end,
--  --["beautysh"] = function(source_name, methods)
--  --  null_ls.register(null_ls.builtins.formatting.beautysh.with({
--  --    extra_args = { "-i", "2" },
--  --  }))
--  --end,
--  --["autopep8"] = function(source_name, methods)
--  --  null_ls.register(null_ls.builtins.formatting.autopep8.with({
--  --    extra_args = { "--indent-size=2", "--ignore=E121" },
--  --  }))
--  --end,
--}

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.shfmt.with({
      extra_args = { "-i", "2" },
    }),
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    --null_ls.builtins.formatting.black,
    --null_ls.builtins.diagnostics.ruff,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    --if vim.fs.root(0, ".stylua.toml") == nil then
    --	null_ls.disable({ name = "stylua" })
    --end
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
    autoformat_quit(client, bufnr)
  end,
})

--fstabfmt -i /etc/fstab
