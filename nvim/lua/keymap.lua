local map = vim.keymap.set
local unmap = vim.keymap.del

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

map({ "t" }, "<Esc>", "<C-\\><C-n>")

vim.g.mapleader = " "

map({ "n" }, "<leader>;", ":noh<cr>", { silent = true })

-- vim-wordmotion
map({ "n", "v", "o" }, "W", "w", {})
map({ "x", "o" }, "aW", "aw", {})
map({ "x", "o" }, "iW", "iw", {})
-- For chaoren/vim-wordmotion colemak
--vim.cmd([[
--  let g:wordmotion_mappings={  'e':'', 'E':'', 'j':'<M-e>', 'J':'<M-E>',  }
--]])
--
-- For chrisgrieser/nvim-spider
map({ "n", "o", "x" }, "w", function()
  require("spider").motion("w")
end, {})
map({ "n", "o", "x" }, "b", function()
  require("spider").motion("b")
end, {})
map({ "n", "o", "x" }, "e", function()
  require("spider").motion("e")
end, {})

map({ "n", "o", "x" }, "W", function()
  require("spider").motion("w", { subwordMovement = false })
end, {})
map({ "n", "o", "x" }, "B", function()
  require("spider").motion("b", { subwordMovement = false })
end, {})
map({ "n", "o", "x" }, "E", function()
  require("spider").motion("e", { subwordMovement = false })
end, {})
--"func() require('spider').motion('e', { subwordMovement = false, skipInsignificantPunctuation=false })<CR>", {})

-- for chrisgrieser/nvim-various-textobjs
--map({ "o", "x" }, "lw", function() require('various-textobjs').subword('inner') end)
map({ "o", "x" }, "iw", function()
  require("various-textobjs").subword("inner")
end)
map({ "o", "x" }, "aw", function()
  require("various-textobjs").subword("outer")
end)
--map({ "o", "x" }, "iW", function() require('various-textobjs').subword('inner')end)
--map({ "o", "x" }, "lW", function() require('various-textobjs').subword('inner')end)
--map({ "o", "x" }, "aW", function() require('various-textobjs').subword('outer')end)
map({ "o", "x" }, "au", function()
  require("various-textobjs").url()
end)
map({ "o", "x" }, "iu", function()
  require("various-textobjs").url()
end)

-- Flash.nvim
-- TODO: fix this/implement
-- selects text puts it into cword
--map({ "n", "o", "x" }, "*", function()
--  local VeryLiteral = false
--
--  function VSetSearch(cmd)
--    local old_reg = vim.fn.getreg('"')
--    local old_regtype = vim.fn.getregtype('"')
--
--    vim.api.nvim_exec_autocmd("TextYankPost", {
--      pattern = "*",
--      callback = function()
--        local y1 = vim.fn.getreg('"')
--        local y2 = vim.fn.getregtype('"')
--
--        if y1 == "" then
--          return
--        end
--
--        vim.fn.setreg('"', y1, y2)
--
--        if string.match(y1, "^%d+[a-zA-Z_,]*$") or (string.match(y1, "^%d+[a-zA-Z %_,]*$") and VeryLiteral) then
--          vim.fn.setreg("/", y1, vim.fn.getregtype("/"))
--        else
--          local pat = vim.fn.escape(y1, cmd .. "\\")
--
--          if VeryLiteral then
--            pat = string.gsub(pat, "\n", "\\n")
--          else
--            pat = string.gsub(pat, "^%s+", "\\s+")
--            pat = string.gsub(pat, "%s+$", "\\s*")
--            pat = string.gsub(pat, "%s+", "_S+")
--          end
--
--          vim.fn.setreg("/", "\\V" .. pat, vim.fn.getregtype("/"))
--        end
--      end,
--    })
--
--    vim.fn.setreg('"', old_reg, old_regtype)
--  end
--
--  --vim.keymap.set({ "visual" }, "*", ":lua VSetSearch('/')<CR>", { desc = "Search forward" })
--  --vim.keymap.set({ "visual" }, "#", ":lua VSetSearch('?')<CR>", { desc = "Search backward" })
--  --vim.keymap.set({ "visual" }, "<kMultiply>", "*", { desc = "Visual mode search multiply" })
--
--  --vim.keymap.set({ "normal" }, "<leader>vl", function()
--  --  VeryLiteral = not VeryLiteral
--  --  print("VeryLiteral " .. tostring(VeryLiteral))
--  --end, { desc = "Toggle VeryLiteral mode" })
--
--  ---- Ensure the mapping is unique
--  --vim.keymap.del({ "normal" }, "<leader>vl")
--
--  VSetSearch("/")
--
--  require("flash").jump({
--    pattern = vim.fn.getreg('"'),
--  })
--end)
--
-- NOTE: delete this when tested it's no longer needed
--function Motion_f()
--  require('flash').jump({
--    search = {
--      forward = true,
--    },
--    jump = {
--      inclusive = true,
--    },
--    -- doesn't do anything for now disable this at top level
--    modes = {
--      char = {
--        multi_line = false,
--      },
--    },
--  });
--end
--
--function Motion_t()
--  require('flash').jump({
--    search = {
--      forward = true,
--    },
--    jump = {
--      inclusive = false,
--    },
--    modes = {
--      char = {
--        multi_line = false,
--      },
--    },
--  });
--end
--
--function Motion_F()
--  require('flash').jump({
--    search = {
--      forward = false,
--    },
--    jump = {
--      inclusive = true,
--    },
--    modes = {
--      char = {
--        multi_line = false,
--      },
--    },
--  });
--end
--
--function Motion_T()
--  require('flash').jump({
--    search = {
--      forward = false,
--    },
--    jump = {
--      inclusive = true,
--      offset = 1,
--    },
--    modes = {
--      char = {
--        multi_line = false,
--      },
--    },
--  });
--end
--
--local rules = { silent = true, noremap = true }
--map({ "o" }, "t", function() Motion_t() end, rules)
--map({ "o" }, "f", function() Motion_f() end, rules)
--map({ "o" }, "T", function() Motion_T() end, rules)
--map({ "o" }, "F", function() Motion_F() end, rules)

-- behave like original OPERATION-MODE
--vim.api.nvim_del_keymap("o", "t")
--vim.api.nvim_del_keymap("o", "f")
--vim.api.nvim_del_keymap("o", "T")
--vim.api.nvim_del_keymap("o", "F")

-- Ccc pick
map({ "n" }, "<leader>c", ":CccPick<cr>", { desc = "color picker" })

-- Markdown preview
map({ "n" }, "<leader><leader>m", ":MarkdownPreviewToggle<cr>", { desc = "markdown preview" })

-- dadbod database ui toggle
map({ "n" }, "<leader>D", ":DBUIToggle<cr>", { desc = "neogit" })

-- Git
map({ "n" }, "<leader>gu", function()
  Snacks.gitbrowse()
end, {})

-- Spellcheck
map({ "n" }, "<leader><leader>S", ":set spell!<cr>", { desc = "toggle spell" })
map({ "n" }, "<leader><leader>s", function()
  require("telescope.builtin").spell_suggest()
end, { desc = "spell suggest" })
--map({ "n" }, "<leader>s", "z=", {})

-- Nnn explorer for showoff
map({ "n" }, "<leader><leader>n", ":NnnExplorer<cr>", { desc = "nnn explorer" })

-- Format buffer
map({ "n", "v" }, "<leader><leader>f", function()
  vim.lsp.buf.format({ rangeFormatting = { dynamicRegistration = true, rangeSupport = true }, async = true })
end, { desc = "format buffer" })

--https://github.com/neovim/neovim/discussions/27042
--
-- Format selection
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

unmap({ "n" }, "grn")
unmap({ "n" }, "grr")
unmap({ "n" }, "gri")
unmap({ "n", "v" }, "gra")
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
map({ "n" }, "<leader>p", '"_dP', {})
-- nnoremap <leader>d "add
-- nnoremap <leader>y "ayy
-- nnoremap <leader>c "acc

-- Ignores clipboardplus
map({ "n" }, "x", '"bx', {})
map({ "n" }, "X", '"bX', {})
--xnoremap <leader>k \"_dP

-- Telescope shortcut
--map({ "n" }, "<leader>:", ":")
map({ "n" }, "<leader>:", ":Telescope cmdline<cr>")
map({ "n" }, "<leader>f", function()
  vim.find_files_from_project_git_root()
end, { desc = "jump files" })
map({ "n" }, "<leader><Tab>", ":Telescope buffers<cr>", { desc = "jump buffers" })
--map({ "n" }, "<leader>c", ":Telescope commands<cr>")
map({ "n" }, "<leader>v", ":Telescope vim_options<cr>")
--map({ "n" }, "<leader>t", ":Telescope builtin include_extensions=true<cr>")

map({ "n" }, "<leader>?a", function()
  vim.lsp.buf.code_action()
end, { desc = "code actions" })
map({ "n" }, "<leader>?k", ":Telescope keymaps<cr>", { desc = "keymaps" })
map({ "n" }, "<leader>?d", ":Telescope diagnostics bufnr=0<cr>", { desc = "workspace diagnostics" })
map({ "n" }, "<leader>?D", ":Telescope diagnostics<cr>", { desc = "workspace diagnostics" })

map({ "n" }, "\\", ":Telescope current_buffer_fuzzy_find<cr>", { desc = "fzf cur_buffer" })
map({ "n" }, "<leader>/", ":Telescope live_grep<cr>", { desc = "telescope grep buffers" })
map({ "n" }, "<leader>m", ":Telescope marks mark_type=local<cr>", { desc = "telescope marks local" })
map({ "n" }, "<leader>M", ":Telescope marks mark_type=global<cr>", { desc = "telescope marks global" })

map({ "n" }, "<leader>u", ":Telescope undo<cr>", { desc = "telescope undo" })

-- Dap
map({ "n" }, "<leader>dc", ":Telescope dap commands<cr>")
map({ "n" }, "<leader>db", ":Telescope dap list_breakpoints<cr>")
map({ "n" }, "<leader>du", function()
  require("dapui").toggle()
end)

-- Notification history
map({ "n" }, "<leader>n", ":Telescope notify<cr>", { desc = "notification history" })

-- NeoComposer Macros
--map({ "n" }, "<leader>q", ":Telescope macros<cr>", { desc = "neocomposer macros" })

-- Overseer
map({ "n" }, "<leader>o", ":OverseerRun<cr>", { desc = "Overseer run command" })

-- Mathematic functions / operations
-- Count time values together HH:MM:SS in visual block
map({ "v" }, "<leader><leader>c", ":MathTimeSum<cr>", { desc = "SUM time values visual" })

map({ "n" }, "<leader><leader>+", ":MathSum<cr>", { desc = "SUM col - yank to register first" })

map({ "n" }, "<leader><leader>*", ":MathMul<cr>", { desc = "MUL col - yank to register first" })

map({ "n" }, "<leader><leader>/", ":MathDiv<cr>", { desc = "DIV col - yank to register first" })

-- Togglables
--map({ "n" }, "<leader><leader>d", function() Snacks.toggle.dim() end, { desc = "toggle dim" })
local isDim = false
map({ "n" }, "<leader><leader>d", function()
  if isDim then
    Snacks.dim.disable()
    isDim = false
  else
    Snacks.dim.enable()
    isDim = true
  end
end, { desc = "toggle dim" })

local isDark = true
map({ "n" }, "<leader><leader>t", function()
  if isDark then
    vim.o.background = "light"
    vim.cmd([[
    :silent !kitty +kitten themes --reload-in=all "Tokyo Night Day"
    ]])
    isDark = false
  else
    vim.o.background = "dark"
    vim.cmd([[
    :silent !kitty +kitten themes --reload-in=all "Tokyo Night Storm"
    ]])
    isDark = true
  end
end, { desc = "toggle theme" })

local isLSP = true
function ToggleLsp()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  if isLSP then
    vim.cmd(":LspStop")
    isLSP = false
    --vim.cmd('echo "LSP off"')
    require("notify")("LSP off")
  else
    vim.cmd(":LspStart")
    isLSP = true
    --vim.cmd('echo "LSP on"')
    require("notify")("LSP on")
  end
end
map({ "n", "o", "x" }, "<leader><leader>l", ToggleLsp, { desc = "toggle lsp" })
map({ "n", "o", "x" }, "<F3>", ToggleLsp, { desc = "toggle lsp" })
map({ "n", "o", "x" }, "<F1>", vim.lsp.buf.hover, { desc = "LSP help" })
map({ "n", "o", "x" }, "<F2>", vim.diagnostic.open_float, { desc = "LSP diagnostic err" })
--map({ "n", "o", "x" }, "<F10>", function()
--  vim.diagnostic.jump({ count = -1, float = true })
--end, { desc = "LSP jump prev diagnoses" })
--map({ "n", "o", "x" }, "<F11>", function()
--  vim.diagnostic.jump({ count = 1, float = true })
--end, { desc = "LSP jump next diagnoses" })

vim.cmd([[
" dapui
"nnoremap <leader>dc :lua require("dap").continue()<cr>
"nnoremap <leader>dR :lua require("dap").restart()<cr>
"nnoremap <leader>dP :lua require("dap").pause()<cr>
""nnoremap <leader>dr :lua require("dap").repl.open()<cr>
"nnoremap <leader>db :lua require("dap").toggle_breakpoint()<cr>
"nnoremap <leader>dl :lua require("dap").run_last()<cr>
"nnoremap <leader>dO :lua require("dap").step_over()<cr>
"nnoremap <leader>di :lua require("dap").step_into()<cr>
"nnoremap <leader>do :lua require("dap").step_out()<cr>
"nnoremap <leader>dh :lua require("dap.ui.widgets").hover()<cr>
"nnoremap <leader>dp :lua require("dap.ui.widgets").preview()<cr>
"nnoremap <leader>ds :lua require("dap.ui.widgets").widgets.centered_float(widgets.scopes)<cr>
"nnoremap <leader>df :lua require("dap.ui.widgets").widgets.centered_float(widgets.frames)<cr>


" GNUInfo
" Only apply the mapping to generated buffers
"if &buftype =~? "nofile" || &buftype =~? "nowrite"
""  nnoremap <buffer> gu :InfoUp<cr>
""  nnoremap <buffer> gn :InfoNext<cr>
""  nnoremap <buffer> gp :InfoPrev<cr>
""  "nnoremap <buffer> gm <Plug>(InfoMenu)
""  function! ToggleInfoMenu()
""    try
""      execute "normal! gm\<Plug>(InfoMenu)"
""    catch /E117/
""      " Handle the error, if needed
""      echo "Error occurred!"
""    endtry
""    execute "q"
""  endfunction
""  nnoremap <buffer> gm :call ToggleInfoMenu()<cr>
""  nnoremap <buffer> gf :InfoFollow<cr>
"  nnoremap gn :VinfoNext<cr>
"  nnoremap gp :VinfoPrev<cr>
"endif
"nnoremap gn :VinfoNext<cr>
"nnoremap gp :VinfoPrev<cr>

" Firenvim
" nnoremap <leader>'l :set lines=
" nnoremap <leader>'c :set columns=

" Folding functions
" za/zA toggle current 1 level/toggle current full
" zr/ZR open all 1 level/open all full
" zm/ZM close all 1 level/close all full

" Resize buffer
nnoremap <leader>+ <C-W>1000+
nnoremap <leader>- <C-W>1000-
nnoremap <leader>= <C-W>=
"nnoremap <C-W>m <C-W>h
"nnoremap <C-W>n <C-W>j
"nnoremap <C-W>e <C-W>k
"nnoremap <C-W>i <C-W>l
"nnoremap <leader>m <C-W>h
"nnoremap <leader>n <C-W>j
"nnoremap <leader>e <C-W>k
"nnoremap <leader>i <C-W>l
"nnoremap <leader>r <C-w><C-r>
nnoremap <C-s> <C-w><C-r>

" Search for selected text.
" http://vim.wikia.com/wiki/VimTip171
let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif
function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction
vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<cr>/<C-R>/<cr>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<cr>?<C-R>/<cr>
vmap <kMultiply> *
nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<cr>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo

" rotate horizontal/vertical buffer"
let g:isHorizontal = 1
function! ToggleRotate(isHorizontal)
  if g:isHorizontal==1
    :exe "normal \<C-w>J"
    let g:isHorizontal = 0
  else
    :exe "normal \<C-w>H"
    let g:isHorizontal = 1
  endif
endfunction
"nnoremap <C-w><C-r> :call ToggleRotate(isHorizontal)<cr>
"nnoremap <leader>r :call ToggleRotate(isHorizontal)<cr>

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

" Jump to first ocurance of search and go to visual mode
" don't see point of this... maybe revork to select whole selection in visual
" noremap \\ //s<cr>v//e+1<cr>

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

nnoremap <silent> <Left>  :<C-u>call MoveAndFoldLeft()<cr>
nnoremap <silent> h       :<C-u>call MoveAndFoldLeft()<cr>
nnoremap <silent> <Right> :<C-u>call MoveAndFoldRight()<cr>
nnoremap <silent> l       :<C-u>call MoveAndFoldRight()<cr>
]])
