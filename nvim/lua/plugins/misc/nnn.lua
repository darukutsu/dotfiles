--local builtin = require("nnn").builtin
--local mappings = {
--  { "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
--  { "<C-s>", builtin.open_in_split }, -- open file(s) in split
--  { "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
--  { "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
--  { "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
--  { "<C-w>", builtin.cd_to_path }, -- cd to file directory
--  { "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
--}

return {
  "luukvbaal/nnn.nvim",
  event = "VeryLazy",
  cmd = { "NnnExplorer", "NnnPicker" },
  keys = function()
    return {
      { "<leader><leader>n", ":NnnExplorer<cr>", { desc = "nnn explorer" } },
      { "<leader>F", ":NnnPicker<cr>", { desc = "nnn explorer" } },
      --{
      --  "<C-t>",
      --  function()
      --    require("nnn").builtin.open_in_tab()
      --  end,
      --  { desc = "nnn open in tab" },
      --},
      --{
      --  "<C-s>",
      --  function()
      --    require("nnn").builtin.open_in_split()
      --  end,
      --  { desc = "nnn open in split" },
      --},
      --{
      --  "<C-v>",
      --  function()
      --    require("nnn").builtin.open_in_vsplit()
      --  end,
      --  { desc = "nnn open in vsplit" },
      --},
      --{
      --  "<C-p>",
      --  function()
      --    require("nnn").builtin.open_in_preview()
      --  end,
      --  { desc = "nnn preview" },
      --},
      --{
      --  "<C-y>",
      --  function()
      --    require("nnn").builtin.copy_to_clipboard()
      --  end,
      --  { desc = "nnn file to clipboard" },
      --},
      --{
      --  "<C-w>",
      --  function()
      --    require("nnn").builtin.cd_to_path()
      --  end,
      --  { desc = "nnn cd to dir" },
      --},
      --{
      --  "<C-e>",
      --  function()
      --    require("nnn").builtin.populate_cmdline()
      --  end,
      --  { desc = "nnn cmdline populate" },
      --},
    }
  end,
  opts = {
    explorer = {
      cmd = "nnn",
      width = 30,
    },
    picker = {
      style = {
        width = 1,
        height = 0.4,
        xoffset = 0,
        yoffset = 1,
        border = "bold",
      },
    },
    -- NOTE: open issue this does not work
    --mappings = mappings,
  },
}
