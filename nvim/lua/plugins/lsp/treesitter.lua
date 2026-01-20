return {
  "nvim-treesitter/nvim-treesitter", -- highlight code
  --event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  dependencies = {
    "chrisgrieser/nvim-various-textobjs",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "MeanderingProgrammer/treesitter-modules.nvim",
    "folke/ts-comments.nvim",
    -- "lewis6991/ts-install.nvim", -- bit more advanced installer
  },
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- new treesitter is very barebone no need to call setup for now
    --require("nvim-treesitter").setup({
    --  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    --  --install_dir = vim.fs.joinpath(vim.fn.stdpath('data') --[[@as string]], 'site'),
    --})

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      --aliases = {
      --  ["your language here"] = "html",
      --},
    })

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

    -- checkhealth for missing tools otherwise this will always print msg
    -- mainly tree-sitter-cli
    --
    -- You don't need this plugin see:
    -- https://github.com/MeanderingProgrammer/treesitter-modules.nvim?tab=readme-ov-file#implementing-yourself
    require("treesitter-modules").setup({
      --ensure_installed = 'all',
      --ensure_installed = ensure_install,
      --ignore_install = ignore_install,

      auto_install = true,

      fold = {
        enable = true,
        disable = false,
      },
      highlight = {
        enable = true,
        disable = false,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = false,
        disable = false,
      },
      indent = {
        enable = true,
        disable = {
          "python",
        },
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
  end,
}
