return {
  "folke/flash.nvim", --better fF
  event = "VeryLazy", -- because of wordmotions
  --lazy = false,
  keys = function()
    return {
      { "f" },
      { "F" },
      { "t" },
      { "T" },
    }
  end,
  ---@type Flash.Config
  opts = {
    -- excluded ydcn
    labels = "arstgmeioqwfpbjluzxvkh",
    search = {
      incremental = false,
      wrap = false,
    },
    jump = {},
    label = {
      rainbow = {
        enabled = true,
        shade = 1,
      },
      after = false,
      before = true,
    },
    highlight = {
      groups = {
        current = "FlashMatch",
      },
    },
    pattern = "",
    continue = false,

    modes = {
      search = {
        enabled = true,
        search = { incremental = true, wrap = true },
        jump = { autojump = true },
      },
      char = {
        enabled = true,
        --config = function(opts)
        --  -- autohide flash when in operator-pending mode
        --  opts.autohide = opts.autohide
        --    or (vim.fn.mode(true):find("no") and (vim.v.operator == "y" or vim.v.operator == "d"))

        --  -- disable jump labels when not enabled, when using a count,
        --  -- or when recording/executing registers
        --  opts.jump_labels = opts.jump_labels
        --    and vim.v.count == 0
        --    and vim.fn.reg_executing() == ""
        --    and vim.fn.reg_recording() == ""

        --  -- Show jump labels only in operator-pending mode
        --  -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
        --end,
        autohide = true,
        jump_labels = true,
        multi_line = false,
        -- for some reason doing `yf[letter]y keeps in insert mode
        -- it's better to use <enter> for that purpose
        label = { exclude = "hjklnyYpPdDiIaAsSrRcCxX" },
        keys = { "f", "F", "t", "T", ";", "," },
        search = { wrap = false },
        jump = { autojump = true },
      },
    },
    prompt = {
      enabled = false,
    },
    remote_op = {
      restore = false,
      motion = false,
    },
  },
  -- can't have together with opts
  --config = function() end,
}
