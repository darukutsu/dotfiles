vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

local function keymaps()
  local maps = {
    preset = "default",
    ["<esc>"] = {
      function(cmp)
        if cmp.snippet_active() then
          -- snippet completion
          return cmp.cancel()
        elseif cmp.get_selected_item() then
          -- still needs to provide esc but can be fixed and its desired anyway
          return cmp.cancel()
        end
      end,
      "fallback",
    },
    ["<cr>"] = { "accept", "fallback" },
    ["<tab>"] = {
      "select_next",
      function() -- sidekick next edit suggestion
        return require("sidekick").nes_jump_or_apply()
      end,
      --function() -- if you are using Neovim's native inline completions
      --  return vim.lsp.inline_completion.get()
      --end,
      "fallback",
    },
    ["<S-tab>"] = { "select_prev", "fallback" },
    ["<C-.>"] = { "snippet_forward", "fallback" },
    ["<C-,>"] = { "snippet_backward", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "show_signature", "hide_documentation" },
    ["<C-h>"] = { "show", "show_documentation", "show_signature", "hide_documentation" },
    ["<C-n>"] = false,
    ["<C-p>"] = false,
    --["<C-k>"] = false,
    ["<A-1>"] = {
      function(cmp)
        cmp.accept({ index = 1 })
      end,
    },
    ["<A-2>"] = {
      function(cmp)
        cmp.accept({ index = 2 })
      end,
    },
    ["<A-3>"] = {
      function(cmp)
        cmp.accept({ index = 3 })
      end,
    },
    ["<A-4>"] = {
      function(cmp)
        cmp.accept({ index = 4 })
      end,
    },
    ["<A-5>"] = {
      function(cmp)
        cmp.accept({ index = 5 })
      end,
    },
    ["<A-6>"] = {
      function(cmp)
        cmp.accept({ index = 6 })
      end,
    },
    ["<A-7>"] = {
      function(cmp)
        cmp.accept({ index = 7 })
      end,
    },
    ["<A-8>"] = {
      function(cmp)
        cmp.accept({ index = 8 })
      end,
    },
    ["<A-9>"] = {
      function(cmp)
        cmp.accept({ index = 9 })
      end,
    },
    ["<A-0>"] = {
      function(cmp)
        cmp.accept({ index = 10 })
      end,
    },
  }

  return maps
end

return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    --"moyiz/blink-emoji.nvim",
    --"MahanRahmati/blink-nerdfont.nvim",
    --"mgalliou/blink-cmp-tmux",
    "disrupted/blink-cmp-conventional-commits",
    --{
    --  "Kaiser-Yang/blink-cmp-dictionary",
    --  dependencies = { "nvim-lua/plenary.nvim" },
    --},
    --"L3MON4D3/LuaSnip",
    {
      "fang2hou/blink-copilot",
      opts = {
        --max_completions = 1,  -- Global default for max completions
        --max_attempts = 2,     -- Global default for max attempts
        --debounce = false,
        --auto_refresh = false,
      },
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = keymaps(),
    signature = {
      enabled = true,
      window = { border = "single" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    cmdline = {
      keymap = {
        ["<esc>"] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.cancel()
            else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
            end
          end,
        },
      },
    },

    completion = {
      documentation = { auto_show = true, window = { border = "single" } },
      accept = { auto_brackets = { enabled = false } },
      list = { selection = { preselect = false, auto_insert = true } },
      ghost_text = { enabled = true },
      trigger = {
        show_on_accept_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_backspace = true,
        show_on_insert = true,
      },

      menu = {
        --auto_show_delay_ms = 0,
        border = "single",
        draw = {
          columns = { { "item_idx" }, { "kind_icon" }, { "label", gap = 1 } },
          components = {
            item_idx = {
              text = function(ctx)
                return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
              end,
              highlight = "BlinkCmpItemIdx",
            },
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
        direction_priority = function()
          local ctx = require("blink.cmp").get_context()
          local item = require("blink.cmp").get_selected_item()
          if ctx == nil or item == nil then
            return { "s", "n" }
          end

          local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
          local is_multi_line = item_text:find("\n") ~= nil

          -- after showing the menu upwards, we want to maintain that direction
          -- until we re-open the menu, so store the context id in a global variable
          if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
            vim.g.blink_cmp_upwards_ctx_id = ctx.id
            return { "n", "s" }
          end
          return { "s", "n" }
        end,
      },
    },

    sources = {
      default = {
        "conventional_commits",
        "lazydev",
        "dadbod",
        "lsp",
        "buffer",
        "path",
        "snippets",
        "copilot",
      },
      per_filetype = {
        --sql = {
        --  "lsp",
        --  "snippets",
        --  "dadbod",
        --  "buffer",
        --  "path",
        --  "copilot",
        --},
      },
      --default = function(ctx)
      --
      --  local success, node = pcall(vim.treesitter.get_node)
      --  if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
      --    return { "buffer" }
      --  else
      --    return { "lsp", "path", "snippets", "buffer" }
      --  end
      --end,
      providers = {
        cmdline = {
          -- ignores cmdline completions when executing shell commands
          enabled = function()
            return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
          end,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        conventional_commits = {
          name = "Conventional Commits",
          module = "blink-cmp-conventional-commits",
          enabled = function()
            return vim.bo.filetype == "gitcommit"
          end,
          ---@module 'blink-cmp-conventional-commits'
          ---@type blink-cmp-conventional-commits.Options
          opts = {}, -- none so far
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        buffer = {
          opts = {
            -- get all buffers, even ones like neo-tree
            --get_bufnrs = vim.api.nvim_list_bufs
            -- or (recommended) filter to only "normal" buffers
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
            max_sync_buffer_size = 20000,
            max_async_buffer_size = 300000,
            max_total_buffer_size = 500000,
          },
        },
        path = {
          opts = {
            show_hidden_files_by_default = true,
          },
        },
        --snippets = { preset = "luasnip"},
        --term = {
        --  --enabled = true,
        --  ghost_text = { enabled = true },
        --},
        ---- some lsps will always be enabled, some are weak
        --lsp = {
        --  fallbacks = {},
        --},
      },
    },

    fuzzy = {
      --implementation = "lua",
      implementation = "prefer_rust_with_warning",
      sorts = {
        "exact",
        -- defaults
        "score",
        "sort_text",
      },
    },
  },
  opts_extend = { "sources.default" },
}
