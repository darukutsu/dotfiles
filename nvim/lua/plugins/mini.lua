return {
  "nvim-mini/mini.nvim", -- whole workflow, using only few functions
  event = "VeryLazy",
  -- lazy = false,
  version = false,
  keys = {},
  config = function()
    local map = vim.keymap.set

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

    --local minimap = require("mini.map")
    --minimap.setup({
    --  integrations = {
    --    minimap.gen_integration.builtin_search(),
    --    minimap.gen_integration.diff(),
    --    minimap.gen_integration.diagnostic(),
    --    minimap.gen_integration.gitsigns(),
    --  },
    --  --symbols = {
    --  --  encode = nil,
    --  --},
    --  window = {
    --    width = 8,
    --    windblend = 75,
    --    --zindex = 1,
    --  },
    --})
    --MiniMap.toggle() -- enable by default
    ---- TODO: maybe later use snacks
    --map("n", "<leader>uf", MiniMap.toggle_focus, { desc = "toggle focus minimap/buf" })
    ----map("n", "<leader>ur", MiniMap.refresh, {desc = ""})
    --map("n", "<leader>us", MiniMap.toggle_side, { desc = "toggle left/right minimap" })
    --map("n", "<leader>ut", MiniMap.toggle, { desc = "toggle minimap" })

    -- Setup diagnostic statusline highlights with preserved background
    require("mini.statusline").setup({
      content = {
        active = function()
          local function location()
            return '%v:%{virtcol("$") - 1} %p%% %L'
          end
          local function nvim_recorder()
            local okrec, rec = pcall(require, "recorder")
            if okrec then
              return rec.recordingStatus():gsub("Recording... ", "Rec") .. rec.displaySlots()
            end
          end
          local function perms()
            if vim.bo.modified then
              return "[MO]"
            --return " "
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
              return "[RO]"
              --return " "
            end
          end
          local function selection_count()
            local mode = vim.fn.mode(true)
            local line_start, col_start = vim.fn.line("v"), vim.fn.col("v")
            local line_end, col_end = vim.fn.line("."), vim.fn.col(".")
            if mode:match("") then
              return tostring(
                string.format("%dx%d", math.abs(line_start - line_end) + 1, math.abs(col_start - col_end) + 1)
              )
            elseif mode:match("V") or line_start ~= line_end then
              return tostring(math.abs(line_start - line_end) + 1)
            elseif mode:match("v") then
              return tostring(math.abs(col_start - col_end) + 1)
            end
          end

          --local function setup_diag_highlights()
          --  local bg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineDevinfo" }).bg or "NONE"

          --  local diags = {
          --    Error = "StatuslineDiagError",
          --    Warn = "StatuslineDiagWarn",
          --    Info = "StatuslineDiagInfo",
          --    Hint = "StatuslineDiagHint",
          --  }

          --  for diag, target in pairs(diags) do
          --    local fg = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. diag }).fg
          --    vim.api.nvim_set_hl(0, target, { fg = fg, bg = bg })
          --  end
          --end

          --setup_diag_highlights()
          --vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_diag_highlights })
          --local diag_hl = {
          --  E = "%#StatuslineDiagError#",
          --  W = "%#StatuslineDiagWarn#",
          --  I = "%#StatuslineDiagInfo#",
          --  H = "%#StatuslineDiagHint#",
          --}
          local diag_hl = {
            E = "%#DiagnosticError#",
            W = "%#DiagnosticWarn#",
            I = "%#DiagnosticInfo#",
            H = "%#DiagnosticHint#",
          }

          local function diagnostics(args)
            local diag = MiniStatusline.section_diagnostics(args)
            if diag == "" then
              return ""
            end

            local result = diag:gsub("([EWIH])(%d+)", function(kind, count)
              return diag_hl[kind] .. kind .. count
              --.. "%#MiniStatuslineDevinfo#"
            end)

            return result
          end
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = diagnostics({
            trunc_width = 75,
          })
          --local diagnostics = MiniStatusline.section_diagnostics({
          --  trunc_width = 75,
          --  signs = {
          --    ERROR = "!",
          --    WARN = "?",
          --    INFO = "@",
          --    HINT = "*",
          --  },
          --})
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = location()
          local nvim_recorder = nvim_recorder()
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local selection_count = selection_count()
          local perms = perms()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode, selection_count, search, "|", location } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, lsp } },
            { hl = "Substitute", strings = { nvim_recorder } },
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "NONE", strings = { diagnostics } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            --{ hl = mode_hl, strings = { perms } },
          })
        end,
      },
    })

    require("mini.splitjoin").setup({
      mappings = {
        toggle = "gs",
      },
    })
    map({ "n", "o", "x" }, "gJ", function()
      MiniSplitjoin.toggle()
    end, { desc = "line split toggle" })
    map({ "n", "o", "x" }, "<leader>J", function()
      MiniSplitjoin.toggle()
    end, { desc = "line split toggle" })

    local gen_spec = require("mini.ai").gen_spec
    require("mini.ai").setup({
      custom_textobjects = {
        s = gen_spec.treesitter({ a = "@statement.outer", i = "@statement.inner" }),
        a = gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
        l = gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
        i = gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
      },

      mappings = {
        goto_left = "g}",
        goto_right = "g{",
      },

      search_method = "cover_or_nearest",
      --n_lines = 1,
    })

    require("mini.snippets").setup({
      -- define your snippets here
      snippets = {},
    })
  end,
}
