--local buf_name = vim.api.nvim_buf_get_name(0)
--local ft = vim.fn.fnamemodify(buf_name, ":t")
--if ft == "man" or ft == "pager" then
--  require("pager")
--end
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.wo.scrolloff = 999
    vim.wo.rnu = true
    vim.wo.nu = true
    --vim.g.no_man_maps = 1
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--vim.g.mapleader = " "

require("keymap")
require("lazy").setup("plugins")
require("plug/sudo")
require("plug/loopcmd")
require("plug/math")

--require('plug/fcitx')
require("plug/suppress-errors")

-- ZLS disable quickfix
vim.g.zig_fmt_parse_errors = 0

vim.api.nvim_create_autocmd("TermOpen", {
  buffer = 0,
  callback = function()
    vim.wo.scrolloff = 999
    vim.wo.rnu = true
    vim.wo.nu = true
  end,
})

vim.cmd([[
  let g:neovide_scroll_animation_length = 0
  "let g:neovide_cursor_animate_command_line = v:false
  "let g:neovide_cursor_trail_size = 0

  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=350}

  "au TermOpen * setlocal relativenumber
  set expandtab
  set tabstop=8
  " after softtabstop*N will turn into <Tab> character
  "set softtabstop=0 noexpandtab
  set shiftwidth=2
  set number relativenumber
  " display both relative and linenumber at same time
  "set statuscolumn=%@SignCb@%=%T%@NumCb@%l%s%r│%T

  set wildmode=longest:full,list,full
  set spelllang=en_us

  "set foldmethod=indent
  "set foldmethod=syntax
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  " Automatic save folds
  "https://www.vim.org/scripts/script.php?script_id=4021
  "autocmd BufWinLeave *.* mkview
  "autocmd BufWinEnter *.* silent loadview
  " Automatic open folds when openinig file
  set foldlevelstart=99

  set cursorline
  "set spell
  "set autoindent
  "set smartindent
  set scrollback=100000

  " fixes man page bindings
  let g:no_man_maps=1

  let g:loaded_node_provide = 0
  let g:loaded_perl_provide = 0
  let g:loaded_python3_provide = 0
  let g:loaded_ruby_provide = 0

  " Alias
  command W noa wq

  " Fucks with block pasting
  set clipboard+=unnamedplus
  "set clipboard+=unnamed

  set cmdheight=0
  "set nowrap

  COQnow -s
]])

-- Commands I tend to forgot
-- :noa wq >>> ignore autocommand for following commands
