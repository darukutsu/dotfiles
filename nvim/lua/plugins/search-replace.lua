return {
  "roobert/search-replace.nvim",
  --event = "VeryLazy",
  keys = function()
    return {
      { "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", mode = "v", desc = "" },
      { "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", mode = "v", desc = "" },
      { "<C-R>", "<CMD>SearchReplaceWithinVisualSelection<CR>", mode = "v", desc = "" },
      { "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", mode = "v", desc = "" },

      { "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", desc = "Selections" },
      { "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "Open" },
      { "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "CWord" },
      { "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "CWORD" },
      { "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "CExpr" },
      { "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "CFile" },

      { "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", desc = "multi Selections" },
      { "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", desc = "multi Open" },
      { "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", desc = "multi CWord" },
      { "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", desc = "multi CWORD" },
      { "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", desc = "multi CExpr" },
      { "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", desc = "multi CFile" },
    }
  end,
  config = function()
    require("search-replace").setup({
      --default_replace_single_buffer_options = "gcI",
      --default_replace_multi_buffer_options = "egcI",
    })
    vim.o.inccommand = "split"
  end,
}
