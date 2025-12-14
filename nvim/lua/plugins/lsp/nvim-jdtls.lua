return {
  "mfussenegger/nvim-jdtls", -- java
  --event = "VeryLazy",
  ft = { "java", "kotlin" },
  dependencies = {
    { "mfussenegger/nvim-dap" },
  },
}
