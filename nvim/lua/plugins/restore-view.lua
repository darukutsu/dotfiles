return {
  "vim-scripts/restore_view.vim", -- save folds
  --event = "UIEnter",
  lazy = false,
  -- opts = {}, -- since this is vim not neovim use config instead
  config = function()
    vim.g.viewoptions = "cursor,folds"
  end,
}
