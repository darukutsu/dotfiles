require("vim._core.ui2").enable()

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.neovide_scroll_animation_length = 0
--vim.g.neovide_cursor_animate_command_line = v:false
--vim.g.neovide_cursor_trail_size = 0
-- fixes man page bindings
vim.g.no_man_maps = 1
vim.o.winborder = "bold"

-- without this autocmd startup is around 2700ms see approx. times in plugins.lua
local aug = vim.api.nvim_create_augroup("BigFileDisable", {})
vim.api.nvim_create_autocmd("BufReadPre", {
  group = aug,
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.fn.expand("<afile>"))
    if ok and stats and stats.size > 200000 then
      vim.b.bigfile = true
      --vim.cmd("syntax off") -- enable in future if big c file encountered or smth
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.wo.scrolloff = 999
    vim.wo.rnu = true
    vim.wo.nu = true
  end,
})

vim.cmd("packadd nvim.tohtml")
vim.cmd("packadd nvim.difftool")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- with this approach lazy.nvim cannot manage its versions but its probably good enough
-- Transition to vim.pack once it provides all necessary features like lazy loading
--vim.pack.add({
--  { src = "https://github.com/folke/lazy.nvim.git", version = "stable" },
--})
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- keymap must be before loading plugins
vim.g.mapleader = " "
require("custom/snackmap")
require("lazy").setup({
  defaults = {
    lazy = true, -- make all plugins lazy by default
  },
  spec = {
    -- all cool plugins see my stared https://github.com/stars/Darukutsu/lists/nvim
    { import = "plugins/ai" },
    { import = "plugins/misc" },
    { import = "plugins/themes" },
    { import = "plugins/lsp" },
    { import = "plugins" },
  },
  performance = {
    cache = {
      enabled = true,
    },
    --rtp = {
    --  disabled_plugins = {
    --    "gzip",
    --    "matchit",
    --    "matchparen",
    --    "netrwPlugin",
    --    "tarPlugin",
    --    "tohtml",
    --    "tutor",
    --    "zipPlugin",
    --  },
    --},
  },
  ui = {
    border = "bold",
    backdrop = 80,
  },
})

require("keymap")
-- TODO: will need rework if more than 10, also don't forget to handle dependencies
require("custom/loopcmd")
require("custom/math")
--require('custom/fcitx')
require("custom/suppress-errors")
require("custom/increment-row")

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

-- Fucks with block pasting
-- needs better handling cuz half of time kitty asks for paste
vim.opt.clipboard:append("unnamedplus")
if vim.env.SSH_TTY ~= nil then
  vim.g.clipboard = "osc52"
elseif vim.fn.has("wsl") == 1 then
  -- Strip \r from paste to avoid ^M from Windows clipboard
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end

-- Automatic open folds when openinig file
--vim.g.foldlevelstart = 99
vim.opt.iskeyword:append("-")

-- NOTE: seems to be doing ootb elsewhere
--vim.o.viewoptions = "folds,cursor"
--vim.api.nvim_create_autocmd("BufWinLeave", {
--  pattern = "*.*",
--  command = "mkview",
--})
--vim.api.nvim_create_autocmd("BufWinEnter", {
--  pattern = "*.*",
--  command = "silent! loadview",
--})

vim.cmd([[
  " NOTE: remove later
  "autocmd FileType sh set filetype=bash

  au TextYankPost * silent! lua vim.highlight.on_yank {timeout=350}
  au TermOpen * setlocal number relativenumber
  set number relativenumber
  " display both relative and linenumber at same time
  "set statuscolumn=%@SignCb@%=%T%@NumCb@%l%s%r│%T

  set wildmode=longest:full,list,full
  set spelllang=en_us,techjargon

  set cursorline
  "set spell
  "set autoindent
  "set smartindent
  set scrollback=100000

  " Alias
  command W noa wq

  set cmdheight=0
  "set nowrap
]])

-- Commands I tend to forgot
-- :noa wq >>> ignore autocommand for following commands
