vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    local has_organize_imports = false
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
      local kinds = type(client.server_capabilities) == "table"
          and type(client.server_capabilities.codeActionProvider) == "table"
          and client.server_capabilities.codeActionProvider.codeActionKinds
        or {}
      if type(kinds) == "table" then
        for _, kind in ipairs(kinds) do
          if type(kind) == "string" and kind:find("organizeImports") then
            has_organize_imports = true
            break
          end
        end
      end
    end

    if has_organize_imports then
      -- too much happening maybe just silence `no codeaction available`
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      })
    end

    require("conform").format({ bufnr = args.buf })
  end,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

return {
  "stevearc/conform.nvim",
  --lazy = false,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader><leader>f",
      function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source.organizeImports" },
            diagnostics = {},
          },
          apply = true,
        })
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      json = { "jq" },
      jsonc = { "jq" },
      markdown = { "mdsf" },
    },
    formatters = {
      shfmt = {
        prepend_args = function(self, ctx)
          local editorconfig = vim.fs.find(".editorconfig", { upward = true, path = ctx.dirname })
          if #editorconfig > 0 then
            return {}
          end
          return { "-i", "2" }
        end,
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      jq = {
        prepend_args = { "--indent", "2" },
      },
    },
  },
}
