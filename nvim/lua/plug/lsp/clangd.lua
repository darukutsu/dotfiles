require("clangd_extensions").setup({})

local function myon_attach()
  --require("clangd_extensions.inlay_hints").setup_autocmd()
  --require("clangd_extensions.inlay_hints").set_inlay_hints()
end

--vim.lsp.config('clangd', {
--  --cmd = { "clangd", "--background-index" },
--  --filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
--settings = {
--  settings = {
--    clangd = {
--      --diagnostic = {
--      --  enable = true,
--      --  -- Disable the specific diagnostic message here
--      --  suppressions = {},
--      --},
--      --formatting = "file",
--      format = {
--        BasedOnStyle = "llvm",
--        TabWidth = 8,
--        IndentWidth = 8,
--        ColumnLimit = 90,
--        SortIncludes = true,
--        IndentCaseLabels = false,
--      },
--      completion = {
--        caseSensitive = false,
--        triggerCharacter = { "." },
--      },
--    },
--  },
--}
--})

--  --init_options = {
--  --  clangdFileStatus = true,
--  --  usePlaceholders = true,
--  --  completeUnimported = true,
--  --  semanticHighlighting = true,
--  --},
