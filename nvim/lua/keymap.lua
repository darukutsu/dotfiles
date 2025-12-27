local map = vim.keymap.set
local unmap = vim.keymap.del

-- Colemak-DH rebinds
--vim.cmd([[
--noremap k m
--noremap j e
--noremap h n
--"noremap l i
--nnoremap l i
--noremap m h
--noremap n j
--noremap e k
--noremap i l
--"noremap K <nop>
--"noremap H M
--noremap J E
--noremap H N
--noremap L I
--noremap M H
--noremap N J
--noremap E K
--"noremap I L
--"map H H
--]])
--unmap({ "n" }, "gcc") -- wordmotion
unmap({ "n" }, "grn")
unmap({ "n" }, "grr")
unmap({ "n" }, "grt")
unmap({ "n" }, "gri")
unmap({ "n", "v" }, "gra")

--vim.opt.timeoutlen = 100
map({ "t" }, "<C-Esc>", "<C-\\><C-n>", { silent = true })

-- disable highlight match
map({ "n" }, "<leader>;", ":noh<cr>", { silent = true })

-- vim-wordmotion
--map({ "n", "v", "o" }, "W", "w", {})
--map({ "x", "o" }, "aW", "aw", {})
--map({ "x", "o" }, "iW", "iw", {})
-- For chaoren/vim-wordmotion colemak
--vim.cmd([[
--  let g:wordmotion_mappings={  'e':'', 'E':'', 'j':'<M-e>', 'J':'<M-E>',  }
--]])
--

-- Git
map({ "n" }, "<leader>gu", function()
  Snacks.gitbrowse()
end, { desc = "open gitbrowse in webbrowser" })

-- Spellcheck
SnackMap({
  lhs = "<leader><leader>S",
  rhs = function()
    vim.cmd("set spell!")
  end,
}, {
  name = "spell",
  op = function()
    return vim.wo.spell
  end,
})

map({ "n" }, "<leader><leader>s", function()
  require("telescope.builtin").spell_suggest()
end, { desc = "spell suggest" })
--map({ "n" }, "<leader>s", "z=", {})

-- Format buffer
map({ "n", "v" }, "<leader><leader>f", function()
  vim.lsp.buf.format({ rangeFormatting = { dynamicRegistration = true, rangeSupport = true }, async = true })
end, { desc = "format buffer" })

----https://github.com/neovim/neovim/discussions/27042
---- Format selection
--map({ "v" }, "<leader><leader>f", function()
--  -- get visual range in (1-indexed row, 0-indexed col)
--  local start_pos = vim.fn.getpos("'<")
--  local end_pos = vim.fn.getpos("'>")
--  vim.lsp.buf.format({
--    --async = true,
--    range = {
--      { start_pos[2], start_pos[3] },
--      { end_pos[2], end_pos[3] },
--    },
--    --range = {
--    --["start"] = vim.api.nvim_buf_get_mark(0, "<"),
--    --["end"] = vim.api.nvim_buf_get_mark(0, ">"),
--    --},
--  })
--end, { desc = "format selection" })

-- Quickfix
--map({ "n" }, "<leader>f", ":vimgrep /\\w\\+/j % \\| copen<cr>", {})

-- Split lines under the cursor
map({ "n" }, "K", "i<CR><Esc>g;", { desc = "reversed 'J'" })

-- NOTE: use mini.move instead
-- Move highlighted text
--map({ "v" }, "<M-j>", ":m '>+1<cr>gv=gv", {})
--map({ "v" }, "<M-k>", ":m '<-2<cr>gv=gv", {})

-- Paste single line N times for visual block
--local function paste_mul()
--  local block_start=vim.api.nvim_call_function("line", {"'<"})
--  local block_end=vim.api.nvim_call_function("line", {"'>"})
--  local col_start=vim.api.nvim_call_function("col", {"'<"})
--  local col_end=vim.api.nvim_call_function("col", {"'>"})
--  for i in block_end - block_start do
--    vim.api.nvim_cmd("normal " + col_start + "|\\<C-v>" + col_end + "|")
--  end
--end
--map({ "v" }, "<leader>P", paste_mul(), {})

-- Navigation
map({ "n" }, "gep", function()
  vim.diagnostic.jump({
    count = -1,
    float = true,
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  })
end, { desc = "jump diag prev err" })
map({ "n" }, "gen", function()
  vim.diagnostic.jump({
    count = 1,
    float = true,
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  })
end, { desc = "jump diag next err" })
map({ "n" }, "geP", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "jump diag prev" })
map({ "n" }, "geN", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "jump diag next" })
map({ "n" }, "ge[", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "jump diag prev err" })
map({ "n" }, "ge]", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "jump diag next err" })
--map({ "n" }, "dp", function()
--  vim.diagnostic.jump({ count = -1, float = true })
--end, {})
--map({ "n" }, "dn", function()
--  vim.diagnostic.jump({ count = 1, float = true })
--end, {})
map({ "n" }, "gw", "<C-]>", { desc = "in help follow word definition" })
map({ "n" }, "gd", function()
  --vim.lsp.buf.definition()
  require("telescope.builtin").lsp_definitions()
end, { desc = "go definition" })
map({ "n" }, "gm", function()
  --vim.lsp.buf.implementation()
  require("telescope.builtin").lsp_implementations()
end, { desc = "telescope implementations" })
map({ "n" }, "gp", function()
  --vim.lsp.buf.document_symbol()
  require("telescope.builtin").lsp_document_symbols()
end, { desc = "telescope document symbols" })

map({ "n" }, "gr", function()
  --vim.lsp.buf.references()
  --vim.lsp.buf.references(nil, { on_list = require("telescope.builtin").lsp_references })
  require("telescope.builtin").lsp_references()
end, { desc = "telescope references" })
map({ "n" }, "]]", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map({ "n" }, "[[", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
map({ "n" }, "g[", "<C-o>", { desc = "go prev file" })
map({ "n" }, "g]", "<C-i>", { desc = "go next file" })
map({ "n" }, "gl", "``", { desc = "jump between 'last' marks in file" })
map({ "n" }, "gL", "''", { desc = "same as 'gl'" })
map({ "n" }, "<leader>R", function()
  vim.lsp.buf.rename()
end, { desc = "LSP Rename cursor" })

-- Center cursor up/down search
map({ "n", "v", "o" }, "<C-u>", "<C-u>zz", {})
map({ "n", "v", "o" }, "<C-d>", "<C-d>zz", {})
map({ "n", "v", "o" }, "'[a-z]", "'[a-z]zz", {})
--map({ "n", "v", "o" }, "n", "<C-u>nzzzv", {})
--map({ "n", "v", "o" }, "N", "<C-d>Nzzzv", {})

-- Scrolling content
map({ "n", "v", "o" }, "<C-j>", "<C-e>", {})
map({ "n", "v", "o" }, "<C-k>", "<C-y>", {})

-- Remap defaults
map({ "n" }, "O", "O<Esc>", {})
map({ "n" }, "o", "o<Esc>", {})
map({ "n" }, "<C-M>", ":Man <C-r><C-w><cr>", {})
map({ "n" }, "<C-S-M>", "<C-t>", {})
--map({ "n" }, "<C-S-K>", ":Man <C-r><C-w><cr>", {})

-- Macro replay
--map({ "n" }, "<leader>q", "@@", {})

-- Clipboard
-- use gp gP instead
--map({ "v" }, "<leader>p", "p", { desc = "yank to reg, overwrites clipboard" })
--map({ "v" }, "<leader>P", "P", { desc = "yank to reg, overwrites clipboard" })
--map({ "n", "v", "o" }, "<leader>d", '"_dd', {desc = 'yank to reg, overwrites clipboard'})
--map({ "n", "v", "o" }, "<leader>y", '"_yy', {desc = 'yank to reg, overwrites clipboard'})
--map({ "n", "v", "o" }, "<leader>c", '"_cc', {desc = 'yank to reg, overwrites clipboard'})

-- Ignores clipboardplus
map({ "n" }, "x", '"_x', {})
map({ "n" }, "X", '"_X', {})
map({ "v" }, "p", '"_dP', {})
map({ "v" }, "P", '"_dP', {})

map({ "n" }, "<leader>f", function()
  vim.find_files_from_project_git_root()
end, { desc = "jump files" })
map({ "n" }, "<leader>?a", function()
  vim.lsp.buf.code_action()
end, { desc = "code actions" })

-- Mathematic functions / operations
-- Count time values together HH:map:SS in visual block
map({ "v" }, "<leader><leader>c", ":MathTimeSum<cr>", { desc = "SUM time values visual" })
map({ "n" }, "<leader><leader>+", ":MathSum<cr>", { desc = "SUM col - yank to register first" })
map({ "n" }, "<leader><leader>*", ":MathMul<cr>", { desc = "MUL col - yank to register first" })
map({ "n" }, "<leader><leader>/", ":MathDiv<cr>", { desc = "DIV col - yank to register first" })

-- TODO: when implemented
---- stylua: ignore
--map({ "n" }, "<leader>zi", function() vim.g.guifont=":h11" end, { desc = "Font big" })
---- stylua: ignore
--map({ "n" }, "<leader>zo", function() vim.g.guifont=":h4" end, { desc = "Font small" })

-- Togglables
if Snacks then
  Snacks.toggle.dim():map("<leader><leader>d")
end
local function ToggleTheme()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.cmd([[
    :silent !kitty +kitten themes --reload-in=all "Tokyo Night Day"
    ]])
  else
    vim.o.background = "dark"
    vim.cmd([[
    :silent !kitty +kitten themes --reload-in=all "Tokyo Night Storm"
    ]])
  end
end
SnackMap({
  lhs = "<leader><leader>t",
  rhs = ToggleTheme,
}, {
  name = "light theme",
  op = function()
    return vim.o.background == "light"
  end,
})

local clients
local function ToggleLsp()
  -- disable/enable at same time
  local isLSP = not vim.diagnostic.is_enabled()
  clients = (clients == {} and vim.lsp.get_clients() or {})
  vim.diagnostic.enable(isLSP)
  vim.lsp.enable(clients, isLSP) -- or vim.lsp.is_enabled()
  require("notify")("LSP and diagnostic: " .. tostring(isLSP)) -- can disable and use statusline
end
for _, keymap in ipairs({ "<leader><leader>l", "<F3>" }) do
  SnackMap({
    lhs = keymap,
    rhs = ToggleLsp,
  }, {
    name = "lsp",
    op = function()
      return not vim.diagnostic.is_enabled()
    end,
  })
end

-- TODO: comeup with solution that works, in file directly it doesn't...
-- and you want to lazy load it on key
--
--local isMarkdown = false
--local function ToggleMarkdown()
--  isMarkdown = not isMarkdown
--  vim.cmd("MarkdownPreviewToggle")
--end
--SnackMap({ lhs = "<leader><leader>m", rhs = ToggleMarkdown }, {
--  name = "markdown-preview",
--  op = function()
--    return isMarkdown
--  end,
--})

map({ "n", "o", "x" }, "<F1>", vim.lsp.buf.hover, { desc = "LSP help" })
map({ "n", "o", "x" }, "<F2>", vim.diagnostic.open_float, { desc = "LSP diagnostic err" })
--map({ "n", "o", "x" }, "<F10>", function()
--  vim.diagnostic.jump({ count = -1, float = true })
--end, { desc = "LSP jump prev diagnoses" })
--map({ "n", "o", "x" }, "<F11>", function()
--  vim.diagnostic.jump({ count = 1, float = true })
--end, { desc = "LSP jump next diagnoses" })

-- Buffer related
map({ "n" }, "<leader>ww", ":new<cr>", { desc = "create new buffer" })
map({ "n" }, "<leader>wn", ":new<cr>", { desc = "create new buffer" })
map({ "n" }, "<leader>wc", ":buf?<cr>", { desc = "buff clone?" })
map({ "n" }, "<leader>+", "<C-W>1000+", { desc = "maximize buff" })
map({ "n" }, "<leader>-", "<C-W>1000-", { desc = "minimize buff" })
map({ "n" }, "<leader>=", "<C-W>=", { desc = "reset buf size" })
map({ "n" }, "<C-s>", "<C-W><C-r>", { desc = "flip buff" })
--map({ "n" }, "<leader>m", "<C-W>h", { desc = "" })
--map({ "n" }, "<leader>n", "<C-W>j", { desc = "" })
--map({ "n" }, "<leader>e", "<C-W>k", { desc = "" })
--map({ "n" }, "<leader>i", "<C-W>l", { desc = "" })

map({ "x" }, "<c-g>", ":s/\\%V", { desc = "rename only visual selection block" })
vim.cmd([[
" replace using S in visual block selection
cnoreabbrev <expr> S/ getcmdtype() == ':' ? 's/\%V' : 'S/'

" Firenvim
" nnoremap <leader>'l :set lines=
" nnoremap <leader>'c :set columns=

" NOTE: Folding functions
" za/zA toggle current 1 level/toggle current full
" zr/ZR open all 1 level/open all full
" zm/ZM close all 1 level/close all full

" TODO: rework
" Paste matching text of last search single word
function! Del_word_delims()
   let reg = getreg('/')
   " After *                i^r/ will give me pattern instead of \<pattern\>
   let res = substitute(reg, '^\\<\(.*\)\\>$', '\1', '' )
   if res != reg
      return res
   endif
   " After * on a selection i^r/ will give me pattern instead of \Vpattern
   let res = substitute(reg, '^\\V'          , ''  , '' )
   let res = substitute(res, '\\\\'          , '\\', 'g')
   let res = substitute(res, '\\n'           , '\n', 'g')
   return res
endfunction
inoremap <silent> <C-R>/ <C-R>=Del_word_delims()<cr>
" Unfold when going in fold going out jk
function! MoveAndFoldLeft()
    let line = getpos('.')[1]
    let col  = getpos('.')[2]

    if l:col ==# 1 && foldlevel(l:line) && v:count1 == 1
        execute "foldclose"
    else
        execute "normal! " . v:count1 . "h"
    endif
endfunction

function! MoveAndFoldRight()
    let line = getpos('.')[1]

    if foldlevel(line) && foldclosed(line) != -1 && v:count1 == 1
        execute "foldopen"
    else
        execute "normal! " . v:count1 . "l"
    endif
endfunction

nnoremap <silent> h       :<C-u>call MoveAndFoldLeft()<cr>
nnoremap <silent> l       :<C-u>call MoveAndFoldRight()<cr>
]])
