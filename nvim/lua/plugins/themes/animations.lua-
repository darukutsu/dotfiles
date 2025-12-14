--require('neoscroll').setup({
--  -- All these keys will be mapped to their corresponding default scrolling animation
--  --mappings = { '<C-y>', '<C-e>', '<C-j>', '<C-k>' },
--  hide_cursor = false,          -- Hide cursor while scrolling
--  stop_eof = true,              -- Stop at <EOF> when scrolling downwards
--  respect_scrolloff = true,     -- Stop scrolling when the cursor reaches the scrolloff margin of the file
--  cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
--  easing_function = "quintic",  -- Default easing function
--  pre_hook = nil,               -- Function to run before the scrolling animation starts
--  post_hook = nil,              -- Function to run after the scrolling animation ends
--  performance_mode = false,     -- Disable "Performance Mode" on all buffers.
--})
--
--local t = {}
--t['<C-y>'] = { 'scroll', { '-0.1', 'false', '10' } }
--t['<C-e>'] = { 'scroll', { '0.1', 'false', '10' } }
--require('neoscroll.config').set_mappings(t)

--require('specs').setup {
--  show_jumps = false,
--  min_jump   = 0,
--  popup      = {
--    delay_ms = 20, -- delay before popup displays
--    inc_ms = 10,   -- time increments used for fade/resize effects
--    blend = 10,    -- starting blend, between 0-100 (fully transparent), see :h winblend
--    width = 10,
--    winhl = "PMenu",
--    fader = require('specs').pulse_fader,
--    resizer = require('specs').shrink_resizer
--  },
--}
-- You can even bind it to search jumping and more, example:
--vim.api.nvim_set_keymap('n', 'n', 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'N', 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })

require('smoothcursor').setup({
  type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".
  --  cursor = nil,
  cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
  texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.

  fancy = {
    enable = true,                                                  -- enable fancy mode
    head = { cursor = " ", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
  },

  matrix = {
    --head = { cursor = " ", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
    --head = {
    --  -- Picks a random character from this list for the cursor text
    --  cursor = require('smoothcursor.matrix_chars'),
    --  -- Picks a random highlight from this list for the cursor text
    --  texthl = {
    --    'SmoothCursor',
    --  },
    --  linehl = nil, -- No line highlight for the head
    --},
    body = {
      length = 6, -- Specifies the length of the cursor body
      -- Picks a random character from this list for the cursor body text
      cursor = require('smoothcursor.matrix_chars'),
      -- Picks a random highlight from this list for each segment of the cursor body
      texthl = {
        'SmoothCursorGreen',
      },
    },
    tail = {
      -- Picks a random character from this list for the cursor tail (if any)
      cursor = nil,
      -- Picks a random highlight from this list for the cursor tail
      texthl = {
        'SmoothCursor',
      },
    },
    unstop = false, -- Determines if the cursor should stop or not (false means it will stop)
  },

  speed = 30,     -- Max speed is 100 to stick with your current position
  intervals = 25, -- Update intervals in milliseconds
})
