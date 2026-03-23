return { -- MASON, formatter/linter, debugger, lsp
  "mason-org/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    --{ "mhartington/formatter.nvim" },
    { "nvimtools/none-ls.nvim" },
    { "jay-babu/mason-null-ls.nvim" },
    { "mfussenegger/nvim-dap" },
    { "jay-babu/mason-nvim-dap.nvim" },
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason-lspconfig.nvim" },
  },
  config = function()
    -- :Mason shows below windows unlike :Lazy which shows above all even telescope
    require("mason").setup({
      ui = {
        border = "bold",
        backdrop = 80,
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

    -- Trying conform.nvim maybe switch from none-ls to nvim-lint as well
    --local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    --local function autoformat_quit(client, bufnr)
    --  if vim.b[bufnr].bigfile then
    --    vim.b.completion = false
    --    return
    --  end
    --  if client:supports_method("textDocument/formatting") then
    --    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --    vim.api.nvim_create_autocmd("BufWritePre", {
    --      group = augroup,
    --      buffer = bufnr,
    --      callback = function()
    --        vim.lsp.buf.code_action({
    --          context = {
    --            only = { "source.organizeImports" },
    --            diagnostics = {},
    --          },
    --          apply = true,
    --        })
    --        vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
    --      end,
    --    })
    --  end
    --end

    --https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
    -- lsphandlers were disabled in nvim0.11+ use vim.lsp.config() instead
    local servers = {
      lua_ls = "lua-language-server",
      harper_ls = "harper-ls",
      ruff = "ruff",
      zig = "zls",
      jdtls = "jdtls",
      clangd = "clangd",
      --matlab = "matlab",
      --ltex = "ltex",
      --kotlin = "kotlin",
    }

    local mason_registry = require("mason-registry")
    for server, mason_name in pairs(servers) do
      local ok, pkg = pcall(mason_registry.get_package, mason_name)
      if ok and pkg:is_installed() then
        require("plugins/lsp/server/" .. server)
      end
    end

    require("mason-lspconfig").setup({
      ensure_installed = {
        "arduino_language_server",
        "asm_lsp",
        "ast_grep", -- better, faster, featurefull semgrep
        "bashls", -- needs dependencies such as shfmt and shellcheck
        "biome", -- faster prettier (but limited to less languages)
        "clangd",
        "docker_language_server",
        "gh_actions_ls",
        "gitlab_ci_ls",
        "gopls",
        --"gradle_ls", -- java disabled because of permissions in job
        "harper_ls",
        "html",
        "htmx",
        "intelephense",
        --"kotlin_lsp", -- java disabled because of permissions in job
        --"jdtls", -- java disabled because of permissions in job
        "jsonls", -- biome does not do json lsp(probably)
        "lemminx",
        "ltex_plus",
        "lua_ls",
        -- "matlab_ls", -- i don't need matlab rn
        "marksman",
        "mesonlsp",
        "ruff",
        "rust_analyzer",
        "sqlls",
        "texlab",
        "tombi",
        "ty",
        "yamlls",
        "zls",
      },
      automatic_installation = false,
      automatic_enable = true,
    })

    require("mason-nvim-dap").setup({
      ensure_installed = {
        "bash-debug-adapter",
        "codelldb",
        "delve",
        "java-debug-adapter",
        "java-test",
      },
      automatic_installation = false,
      handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("mason-nvim-dap").default_setup(server_name)
        end,
      },
    })

    --https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting
    --https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
    --
    --if unsupported when installing new check this
    --https://github.com/nvimtools/none-ls.nvim/discussions/81
    local null_ls = require("null-ls")
    require("mason-null-ls").setup({
      ensure_installed = {
        -- Linter
        "actionlint",
        "codespell",
        "detekt",
        "htmlhint",
        --"markdownlint", -- linter and formatter
        "shellcheck",
        "textlint", -- markdown/txt linter
        "yamllint",
        -- Formatter
        "asmfmt",
        "clang_format",
        "mdsf", -- codeblock only, probably needs setup
        "mdformat", -- some codeblock and rest of markdown
        -- "miss_hit", -- formatter/linter matlab i don't need rn
        "pyproject-fmt",
        "jq",
        "shfmt",
        "sqruff",
        "stylua", -- one day discuss with someone whether this is needed since lua_ls does formatting
      },

      automatic_installation = false,
      --methods = {
      --  diagnostics = false,
      --  formatting = true,
      --  code_actions = false,
      --  completion = false,
      --  hover = false,
      --},

      -- implicit automatic setup when empty
      handlers = {},
    })

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2" },
        }),
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
      },
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
        --autoformat_quit(client, bufnr)
      end,
    })

    -- don't use Wiki on git repo for lspconfig rather use :help lspconfig or :help lsp

    -- Show line diagnostics automatically in hover window
    --vim.o.updatetime = 250
    --vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

    vim.diagnostic.config({
      --virtual_lines = { current_line = true },
      --virtual_text = false,

      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          --[vim.diagnostic.severity.WARN] = " ",
          --[vim.diagnostic.severity.HINT] = " ",
          --[vim.diagnostic.severity.HINT] = "󰮦 ",
          [vim.diagnostic.severity.HINT] = " ",
          --[vim.diagnostic.severity.HINT] = "󰋖 ",
          [vim.diagnostic.severity.INFO] = " ",
          --[vim.diagnostic.severity.INFO] = "󰙎 ",
          --"󰋖 " " "
        },
      },
    })

    -- COMPLETION KINDS
    local M = {}

    M.icons = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = "了 ",
      EnumMember = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = "ﰮ ",
      Keyword = " ",
      Method = "ƒ ",
      Module = " ",
      Property = " ",
      Snippet = "﬌ ",
      Struct = " ",
      Text = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    }

    function M.setup()
      local kinds = vim.lsp.protocol.CompletionItemKind
      for i, kind in ipairs(kinds) do
        kinds[i] = M.icons[kind] or kind
      end
    end

    return M
  end,
}
