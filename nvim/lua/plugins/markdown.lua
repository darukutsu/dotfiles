local ft = { "markdown", "md" }

return {
  {
    "iamcco/markdown-preview.nvim",
    --event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    ft = ft,
    keys = function()
      return {
        { "<leader><leader>m", ":MarkdownPreviewToggle<cr>", { desc = "Toggle MarkdownPreview" } },
      }
    end,
    init = function()
      vim.g.mkdp_filetypes = ft
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    ft = ft,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = function()
      return {
        { "<leader><leader>M", ":RenderMarkdown toggle<cr>", { desc = "Toggle RenderMarkdown" } },
      }
    end,
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true } },
      heading = {
        render_modes = true,
      },
      code = {
        render_modes = true,
      },
      dash = {
        render_modes = true,
      },
      document = {
        render_modes = true,
      },
      bullet = {
        render_modes = true,
      },
      checkbox = {
        render_modes = true,
      },
      quote = {
        render_modes = true,
      },
      pipe_table = {
        render_modes = true,
      },
      link = {
        render_modes = true,
      },
      inline_highlight = {
        render_modes = true,
      },
      indent = {
        render_modes = true,
      },
      html = {
        render_modes = true,
      },
      paragraph = {
        render_modes = true,
      },
      latex = {
        render_modes = true,
      },
    },
  },
}
