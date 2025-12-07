--require("mini.clue").setup{}
--require("mini.git").setup{}
--require("mini.align").setup{}
--require("mini.pairs").setup{}
--require("mini.bracketed").setup{}
--require("mini.operator").setup{} -- verycool but no idea about usecase
--require("mini.cursorword").setup{}

require("mini.surround").setup({
  mappings = {
    add = "#a", -- Add surrounding in Normal and Visual modes
    delete = "#d", -- Delete surrounding
    find = "#f", -- Find surrounding (to the right)
    find_left = "#F", -- Find surrounding (to the left)
    highlight = "#h", -- Highlight surrounding
    replace = "#r", -- Replace surrounding

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },

  search_method = "cover_or_nearest",
  --n_lines = 1,
})
require("mini.move").setup({})
require("mini.splitjoin").setup({
  mappings = {
    toggle = "gs",
  },
})

local gen_spec = require("mini.ai").gen_spec
require("mini.ai").setup({
  custom_textobjects = {
    s = gen_spec.treesitter({ a = "@statement.outer", i = "@statement.inner" }),
    a = gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
    f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
    i = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
    -- something is with my macro-replay this suits as test if they work (they dont for now)
    --s = gen_spec.treesitter({ a = "@statement.outer", desc = "outer statement" }),
    --s = gen_spec.treesitter({ a = "@statement.outer", desc = "outer statement" }),
    --s = gen_spec.treesitter({ a = "@statement.outer", desc = "outer statement" }),
  },

  mappings = {
    goto_left = "g}",
    goto_right = "g{",
  },

  search_method = "cover_or_nearest",
  --n_lines = 1,
})

local map = vim.keymap.set
map({ "n", "o", "x" }, "gJ", function()
  MiniSplitjoin.toggle()
end, {})
map({ "n", "o", "x" }, "<leader>J", function()
  MiniSplitjoin.toggle()
end, {})
