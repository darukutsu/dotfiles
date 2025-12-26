require("clangd_extensions").setup({})

-- NOTE: not sure how much of these are defaults
vim.lsp.config("clangd", {
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac", -- AutoTools
    "Makefile",
    "configure.ac",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja",
    ".git",
  },
  cmd = {
    "clangd",
    "-j=8",
    "--malloc-trim",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  --filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  --settings = {
  --  settings = {
  --    clangd = {
  --      --diagnostic = {
  --      --  enable = true,
  --      --  -- Disable the specific diagnostic message here
  --      --  suppressions = {},
  --      --},
  --      --formatting = "file",
  --      --format = {
  --      --  BasedOnStyle = "llvm",
  --      --  TabWidth = 8,
  --      --  IndentWidth = 8,
  --      --  ColumnLimit = 90,
  --      --  SortIncludes = true,
  --      --  IndentCaseLabels = false,
  --      --},
  --      --completion = {
  --      --  caseSensitive = false,
  --      --  triggerCharacter = { "." },
  --      --},
  --    },
  --  },
  --},
  capabilities = {
    offsetEncoding = "utf-16",
    documentFormattingProvider = false,
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
})
