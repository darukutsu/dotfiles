local ft = { "markdown", "md" }
return {
  "iamcco/markdown-preview.nvim",
  --event = "VeryLazy",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install && git restore .",
  ft = ft,
  init = function()
    vim.g.mkdp_filetypes = ft
  end,
}
