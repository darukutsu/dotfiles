-- colorize text depending on language

local ts = require("nvim-treesitter")

local ignore_install = {
  "zig",
}

local ensure_install = {
  "asm",
  "bash",
  "c",
  "comment",
  "cmake",
  --"cpp",
  "css",
  "csv",
  "desktop",
  "devicetree",
  "dockerfile",
  "diff",
  "go",
  "gomod",
  "gosum",
  "gitignore",
  "gitcommit",
  "gitattributes",
  "git_config",
  "editorconfig",
  "html",
  "http",
  "ini",
  "json",
  "jsonc",
  "jsdoc",
  "sql",
  --"typescript",
  --"javascript",
  --"latex",
  "lua",
  "luap",
  "luadoc",
  "kconfig",
  "vim",
  "vimdoc",
  "make",
  --"markdown",
  --"markdown_inline",
  --"meson",
  "passwd",
  "printf",
  "powershell",
  --"php",
  "python",
  "regex",
  "rust",
  "norg",
  "scss",
  --"svelte",
  "tsx",
  "typst",
  "toml",
  "udev",
  "yaml",
  "vue",
  "nix",
  "xml",
  "query",
}

---@generic T
---@param super T[]
---@param sub T[]
---@return T[]
function table.except(super, sub)
  local result = {}
  local seenInResult = {}
  local lookupSub = {}

  for _, value in ipairs(sub) do
    lookupSub[value] = true
  end

  for _, value in ipairs(super) do
    if not lookupSub[value] and not seenInResult[value] then
      table.insert(result, value)
      seenInResult[value] = true
    end
  end

  return result
end
ts.install(table.except(ensure_install, ts.get_installed()))

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.list_contains(ts.get_installed(), vim.treesitter.language.get_lang(args.match)) then
      vim.treesitter.start(args.buf)
    end
  end,
})

ts.setup({
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    --disable = {
    --  "python",
    --},
  },
  autotag = {
    enable = true,
  },
})

vim.api.nvim_create_user_command("TSStart", function(args)
  local buf = tonumber(args.fargs[1]) or bufnr
  local lang = args.fargs[1]
  if buf then
    lang = args.fargs[2]
  end
  vim.treesitter.start(buf, lang)
end, { nargs = "+" })

vim.api.nvim_create_user_command("TSStop", function(args)
  local buf = tonumber(args.fargs[1]) or bufnr
  vim.treesitter.stop(buf)
end, { nargs = "?" })

local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
local map = vim.keymap.set

-- Repeat movement with ; and ,
-- ensure ; goes forward and, goes backward regardless of the last direction
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
--map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
--map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
--map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
--map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

require("nvim-treesitter-textobjects").setup({
  --select = {
  --  lookahead = true,
  --  --selection_modes = {
  --  --  ['@parameter.outer'] = 'v', -- charwise
  --  --  ['@function.outer'] = 'V',  -- linewise
  --  --  ['@class.outer'] = '<c-v>', -- blockwise
  --  --},
  --  include_surrounding_whitespace = true,
  --},
  move = {
    set_jumps = true,
  },
})

-- @statement works on sentences too
local map_select = function(key, operation, type, desc)
  vim.keymap.set({ "x", "o" }, key, function()
    require("nvim-treesitter-textobjects.select")[operation](type)
  end, { desc = desc })
end
map_select("as", "select_textobject", "@statement.outer", "outer statement")
map_select("is", "select_textobject", "@statement.outer", "inner statement")
map_select("aa", "select_textobject", "@parameter.outer", "outer parameter")
map_select("ia", "select_textobject", "@parameter.inner", "inner parameter")
map_select("af", "select_textobject", "@function.outer", "outer function")
map_select("if", "select_textobject", "@function.inner", "inner function")
map_select("ac", "select_textobject", "@class.outer", "outer class")
map_select("ic", "select_textobject", "@class.inner", "inner class")
map_select("al", "select_textobject", "@loop.outer", "outer loop")
map_select("il", "select_textobject", "@loop.inner", "inner loop")
map_select("ai", "select_textobject", "@conditional.outer", "outer condi")
map_select("ii", "select_textobject", "@conditional.inner", "inner condi")

local map_swap = function(key, operation, type, desc)
  vim.keymap.set({ "n" }, key, function()
    require("nvim-treesitter-textobjects.swap")[operation](type)
  end, { desc = desc })
end
map_swap("<leader>sa", "swap_next", "@parameter.inner")
map_swap("<leader>ss", "swap_next", "@statement.inner")
map_swap("<leader>si", "swap_next", "@conditional.inner")
map_swap("<leader>sA", "swap_previous", "@parameter.inner")
map_swap("<leader>sS", "swap_previous", "@statement.inner")
map_swap("<leader>sI", "swap_previous", "@conditional.inner")

local map_move = function(key, operation, type, group, desc)
  vim.keymap.set({ "n", "x", "o" }, key, function()
    require("nvim-treesitter-textobjects.move")[operation](type, group)
  end, { desc = desc })
end
--map_move("]m", "goto_next_start", "@function.*", "textobjects", "jmp start func")
--map_move("]f", "goto_next_start", "@function.*", "textobjects", "jmp start func")
--map_move("]]", "goto_next_start", "@class.outer", "textobjects", "Next class start")
--map_move("]o", "goto_next_start", "@loop.*", "textobjects", "jmp start loop")
--map_move("]l", "goto_next_start", "@loop.*", "textobjects", "jmp start loop")
--map_move("]s", "goto_next_start", "@scope", "locals", "Next scope")
--map_move("]z", "goto_next_start", "@fold", "folds", "Next fold")
--
--map_move("]M", "goto_next_end", "@function.*", "textobjects", "jmp NEnd func")
--map_move("]F", "goto_next_end", "@function.*", "textobjects", "jmp NEnd func")
--map_move("]p", "goto_next_end", "@parameter.*", "textobjects", "jmp NEnd param")
--map_move("]a", "goto_next_end", "@parameter.*", "textobjects", "jmp NEnd param")
--
--map_move("[m", "goto_previous_start", "@function.*", "textobjects", "jmp PStart func")
--map_move("[f", "goto_previous_start", "@function.*", "textobjects", "jmp PStart func")
--map_move("[[", "goto_previous_start", "@class.*", "textobjects", "jmp PStart class")
--map_move("[o", "goto_previous_start", "@loop.*", "textobjects", "jmp PStart func")
--
--map_move("[M", "goto_previous_end", "@function.*", "textobjects", "jmp PEnd func")
--map_move("[F", "goto_previous_end", "@function.*", "textobjects", "jmp PEnd func")
--map_move("[]", "goto_previous_end", "@class.*", "textobjects", "jmp PEnd class")
--map_move("[p", "goto_previous_end", "@parameter.*", "textobjects", "jmp PEnd param")
--map_move("[a", "goto_previous_end", "@parameter.*", "textobjects", "jmp PEnd param")

map_move("]f", "goto_next", "@function.outer", "textobjects", "next func")
map_move("]p", "goto_next", "@parameter.outer", "textobjects", "next param")
map_move("]s", "goto_next", "@statement.outer", "textobjects", "next statement")
map_move("]c", "goto_next", "@class.outer", "textobjects", "next class")
map_move("]d", "goto_next", "@conditional.outer", "textobjects", "next condi")
map_move("]i", "goto_next", "@conditional.outer", "textobjects", "next condi")
map_move("]o", "goto_next", "@loop.outer", "textobjects", "next loop")
map_move("]l", "goto_next", "@loop.outer", "textobjects", "next loop")
map_move("]r", "goto_next", "@return.outer", "textobjects", "next return")

map_move("[f", "goto_previous", "@function.outer", "textobjects", "prev func")
map_move("[p", "goto_previous", "@parameter.outer", "textobjects", "prev param")
map_move("[s", "goto_previous", "@statement.outer", "textobjects", "prev statement")
map_move("[c", "goto_previous", "@class.outer", "textobjects", "prev class")
map_move("[d", "goto_previous", "@conditional.outer", "textobjects", "prev condi")
map_move("[i", "goto_previous", "@conditional.outer", "textobjects", "prev condi")
map_move("[o", "goto_previous", "@loop.outer", "textobjects", "prev loop")
map_move("[l", "goto_previous", "@loop.outer", "textobjects", "prev loop")
map_move("[r", "goto_previous", "@return.outer", "textobjects", "prev return")
