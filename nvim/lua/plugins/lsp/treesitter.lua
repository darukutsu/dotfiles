return {
  "nvim-treesitter/nvim-treesitter", -- highlight code
  event = "VeryLazy",
  dependencies = {
    "chrisgrieser/nvim-various-textobjs",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  branch = "main",
  build = ":TSUpdate",
  config = function()
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
  end,
}
