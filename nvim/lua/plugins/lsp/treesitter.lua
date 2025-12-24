return {
  "nvim-treesitter/nvim-treesitter", -- highlight code
  --event = { "BufReadPre", "BufNewFile" },
  lazy = false,
  dependencies = {
    "mks-h/treesitter-autoinstall.nvim",
    "chrisgrieser/nvim-various-textobjs",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- colorize text depending on language
    local ts = require("nvim-treesitter")

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

    -- TODO: remove later after testing autoinstall
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
    require("treesitter-autoinstall").setup()

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
  end,
}
