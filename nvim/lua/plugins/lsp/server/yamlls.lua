vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      --schemas = {
      --  ["https://json.schemastore.org/azure-pipelines.json"] = "azure-pipelines*.yml",
      --  ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
      --  kubernetes = "*.yaml",
      --},
      validate = true,
      hover = true,
      completion = true,
      editor = {
        formatOnType = true,
        tabSize = 2,
      },
      format = {
        enable = true,
        printWidth = 120,
        proseWrap = "always",
      },
      maxItemsComputed = 10000,
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
})
