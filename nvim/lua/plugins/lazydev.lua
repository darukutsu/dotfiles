return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- you can specify here multiple libraries
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "nvim-dap-ui",
        "neotest",
        "blink.cmp",
        "mini",
        "mason",
        "telescope",
        "snacks",
      },
    },
  },
  {
    "folke/neoconf.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
