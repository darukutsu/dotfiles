vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.neovide_scroll_animation_length = 0
--vim.g.neovide_cursor_animate_command_line = v:false
--vim.g.neovide_cursor_trail_size = 0
-- fixes man page bindings
vim.g.no_man_maps = 1

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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
require("keymap")
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
  --ui = {
  --  border = "rounded",
  --},
})

require("custom/sudo")
require("custom/loopcmd")
require("custom/math")
--require('custom/fcitx')
require("custom/suppress-errors")

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

---- system clipboard ssh speeds maybe ?
--vim.opt.clipboard:append("unnamedplus")
---- Fix "waiting for osc52 response from terminal" message
---- https://github.com/neovim/neovim/issues/28611
--if vim.env.SSH_TTY ~= nil then
--  -- Set up clipboard for ssh
--  local function my_paste(_)
--    return function(_)
--      local content = vim.fn.getreg('"')
--      return vim.split(content, "\n")
--    end
--  end
--  vim.g.clipboard = {
--    name = "OSC 52",
--    copy = {
--      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--    },
--    paste = {
--      -- No OSC52 paste action since wezterm doesn't support it
--      -- Should still paste from nvim
--      ["+"] = my_paste("+"),
--      ["*"] = my_paste("*"),
--    },
--  }
--end

vim.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.foldmethod = "expr"
--vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
--vim.wo[0][0].foldmethod = "expr"
-- Automatic open folds when openinig file
--vim.g.foldlevelstart = 99
--vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.cmd([[
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

  set cursorline
  "set spell
  "set autoindent
  "set smartindent
  set scrollback=100000

  " Alias
  command W noa wq

  " Fucks with block pasting
  set clipboard+=unnamedplus
  "set clipboard+=unnamed

  set cmdheight=0
  "set nowrap
]])

-- Commands I tend to forgot
-- :noa wq >>> ignore autocommand for following commands
