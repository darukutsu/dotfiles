return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  --lazy = false,
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "debugloop/telescope-undo.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "jonarrien/telescope-cmdline.nvim" },
    --{ "gbrlsnchs/telescope-lsp-handlers.nvim" }, -- FIX: deprecated
  },
  config = function()
    local Layout = require("nui.layout")
    local Popup = require("nui.popup")
    local tel = require("telescope")
    local TSLayout = require("telescope.pickers.layout")

    local function make_popup(options)
      local popup = Popup(options)
      function popup.border:change_title(title)
        popup.border.set_text(popup.border, "top", title)
      end

      return TSLayout.Window(popup)
    end

    --https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
    local function dynamic_ivy()
      return {
        --grep_open_files = true,
        layout_strategy = "flex",
        --dynamic_preview_title = true,
        layout_config = {
          horizontal = {
            size = {
              width = "100%",
              height = "50%",
            },
          },
          vertical = {
            size = {
              width = "100%",
              height = "60%",
            },
          },
        },
        create_layout = function(picker)
          local border = {
            results = {
              top_left = "┌",
              top = "─",
              top_right = "┬",
              right = "│",
              bottom_right = "",
              bottom = "",
              bottom_left = "",
              left = "│",
            },
            results_patch = {
              minimal = {
                top_left = "┌",
                top_right = "┐",
              },
              horizontal = {
                top_left = "┌",
                top_right = "┬",
              },
              vertical = {
                top_left = "├",
                top_right = "┤",
              },
            },
            prompt = {
              top_left = "├",
              top = "─",
              top_right = "┤",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            prompt_patch = {
              minimal = {
                bottom_right = "┘",
              },
              horizontal = {
                bottom_right = "┴",
              },
              vertical = {
                bottom_right = "┘",
              },
            },
            preview = {
              top_left = "┌",
              top = "─",
              top_right = "┐",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            preview_patch = {
              minimal = {},
              horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
              },
              vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = "│",
                top_left = "┌",
              },
            },
          }

          local results = make_popup({
            focusable = false,
            border = {
              style = border.results,
              text = {
                top = picker.results_title,
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local prompt = make_popup({
            enter = true,
            border = {
              style = border.prompt,
              text = {
                top = picker.prompt_title,
                top_align = "left",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal",
            },
          })

          local preview = make_popup({
            focusable = false,
            border = {
              style = border.preview,
              text = {
                top = picker.preview_title,
                top_align = "center",
              },
            },
          })

          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 2 }),
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 2 }),
            }, { dir = "col" }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(results, { grow = 1 }),
                Layout.Box(prompt, { size = 2 }),
              }, { dir = "col", size = "50%" }),
              Layout.Box(preview, { size = "50%" }),
            }, { dir = "row" }),
            minimal = Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 2 }),
            }, { dir = "col" }),
          }

          local function get_box()
            local strategy = picker.layout_strategy
            if strategy == "vertical" or strategy == "horizontal" then
              return box_by_kind[strategy], strategy
            end

            local height, width = vim.o.lines, vim.o.columns
            local box_kind = "horizontal"

            if width < 120 then
              box_kind = "vertical"
              --if height < 40 then
              --  box_kind = "minimal"
              --end
              -- means that preview content is probably empty
              if picker.preview_title == nil then
                if height < 40 then
                  height = math.floor(height / 2.2)
                else
                  height = math.floor(height / 2.8)
                end

                picker.layout_config = {
                  vertical = {
                    size = {
                      width = "100%",
                      height = height,
                    },
                  },
                }
                box_kind = "minimal"
              end
            end
            return box_by_kind[box_kind], box_kind
          end

          local function prepare_layout_parts(layout, box_type)
            layout.results = results
            results.border:set_style(border.results_patch[box_type])

            layout.prompt = prompt
            prompt.border:set_style(border.prompt_patch[box_type])

            if box_type == "minimal" then
              layout.preview = nil
            else
              layout.preview = preview
              preview.border:set_style(border.preview_patch[box_type])
            end
          end

          local function get_layout_size(box_kind)
            return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
          end

          local box, box_kind = get_box()
          local layout = Layout({
            relative = "editor",
            position = "100%",
            size = get_layout_size(box_kind),
          }, box)

          layout.picker = picker
          prepare_layout_parts(layout, box_kind)

          local layout_update = layout.update
          function layout:update()
            local box, box_kind = get_box()
            prepare_layout_parts(layout, box_kind)
            layout_update(self, { size = get_layout_size(box_kind) }, box)
          end

          return TSLayout(layout)
        end,
      }
    end

    --local function no_preview()
    --  require("telescope.themes").get_dropdown({
    --    --borderchars = {
    --    --  { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    --    --  prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
    --    --  results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    --    --  preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    --    --},
    --    layout_strategy = "vertical",
    --    previewer = false,
    --    --layout_config = {
    --    --anchor = "S",
    --    --anchor_padding = 0,
    --    --height = 0.5,
    --    --width = 0.2,
    --    --},
    --    title = true,
    --    results_title = true,
    --  })
    --end

    --local function cursor()
    --  require("telescope.themes").get_cursor({
    --    borderchars = {
    --      { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --      prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    --      results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
    --      preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    --    },
    --    previewer = true,
    --    layout_config = {
    --      height = 0.5,
    --      width = 0.2,
    --    },
    --    title = false,
    --    results_title = false,
    --  })
    --end

    tel.setup({
      defaults = dynamic_ivy(),
      pickers = dynamic_ivy(),
      --pickers = {
      --  buffers = dynamic_ivy(),
      --  live_grep = dynamic_ivy(),
      --  find_files = dynamic_ivy(),
      --  current_buffer_fuzzy_find = dynamic_ivy(),
      --  undo = dynamic_ivy(),
      --  diagnostics = dynamic_ivy(),
      --  --lsp_document_symbols = cursor(),
      --  keymaps = dynamic_ivy(),
      --  vim_options = dynamic_ivy(),
      --  commands = dynamic_ivy(),
      --  --dap = cursor(),
      --},
      extensions = {
        --notify = dynamic_ivy(),
        --["ui-select"] = no_preview(),
        undo = {
          side_by_side = true,
          preview_title = "Undo Diff",
        },
        --cmdline = {
        --},
        --lsp_handlers = {
        --  code_action = {
        --    telescope = cursor(),
        --  },
        --},
      },
    })

    -- adds linenumber in preview window
    vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

    function vim.find_files_from_project_git_root()
      local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        return vim.v.shell_error == 0
      end
      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", ".;")
        return vim.fn.fnamemodify(dot_git_path, ":h")
      end
      local opts = {}
      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
        }
      end
      require("telescope.builtin").find_files(opts)
    end

    tel.load_extension("undo")
    tel.load_extension("dap")
    --tel.load_extension("ui-select") -- probably using snacks instead of this
    --tel.load_extension("lsp_handlers") -- FIX: nvim 0.11 not working
    tel.load_extension("cmdline")
    --tel.load_extension("macros") -- using nvim-recorder instead
  end,
}
