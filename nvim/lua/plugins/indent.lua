return {
  --{
  --  "tpope/vim-sleuth", -- complex heuristic shiftwidth
  --  lazy = false,
  --  -- opts = {}, -- since this is vim not neovim use config instead
  --  config = function() end,
  --},
  {
    "nmac427/guess-indent.nvim", -- fast heuristic shiftwidth
    --event = "VeryLazy",
    lazy = false,
    opts = {
      auto_cmd = true,
      filetype_exclude = {},
      buftype_exclude = {},
      on_tab_options = {},
      on_space_options = {
        ["shiftwidth"] = "detected",
      },
    },
    --config = function() require('guess-indent').setup {} end,
  },
}
