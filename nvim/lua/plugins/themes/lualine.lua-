return { -- fancy line
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "folke/tokyonight.nvim" },
    { "e-ink-colorscheme/e-ink.nvim" },
  },
  config = function()
    local colors = {
      red = "#e00030",
      grey = "#a0a1a7",
      black = "#383a42",
      white = "#f3f3f3",
      light_green = "#83a598",
      orange = "#fe8019",
      green = "#8ec07c",
      blue = "#80a0ff",
      violet = "#d183e8",
    }

    local empty = require("lualine.component"):extend()
    function empty:draw(default_highlight)
      self.status = ""
      self.applied_separator = ""
      self:apply_highlights(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < "x"
        for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
          table.insert(section, pos * 2, { empty })
          --table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
        end
        for id, comp in ipairs(section) do
          if type(comp) ~= "table" then
            comp = { comp }
            section[id] = comp
          end
          comp.separator = left and { right = "" } or { left = "" }
        end
      end
      return sections
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ""
      end
      local last_search = vim.fn.getreg("/")
      if not last_search or last_search == "" then
        return ""
      end
      local searchcount = vim.fn.searchcount({ maxcount = 9999 })
      return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
    end

    local function modified()
      if vim.bo.modified then
        return ""
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return ""
      end
      return ""
    end

    require("lualine").setup({
      extensions = { "quickfix", "mason", "nvim-dap-ui", "man", "overseer" },
      options = {
        --theme = "tokyonight",
        section_separators = { left = "", right = "" },
      },
      sections = process_sections({
        lualine_a = {
          "mode",
          --{ require('NeoComposer.ui').status_recording },
        },
        lualine_c = {
          "branch",
          "diff",
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "error" },
            diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
          },
          {
            "diagnostics",
            source = { "nvim" },
            sections = { "warn" },
            diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
          },
          { "filename", file_status = false, path = 1 },
          {
            "%w",
            cond = function()
              return vim.wo.previewwindow
            end,
          },
          {
            "%r",
            cond = function()
              return vim.bo.readonly
            end,
          },
          {
            "%q",
            cond = function()
              return vim.bo.buftype == "quickfix"
            end,
          },
        },
        lualine_b = { "%l:%c", "selectioncount", "%p%% %L" },
        lualine_x = { "overseer" },
        lualine_y = {
          search_result,
          "filetype",
        },
        lualine_z = {
          "encoding",
          "fileformat",
          { modified, color = { fg = colors.white, bg = colors.red } },
        },
      }),
      inactive_sections = {
        lualine_c = { "%f %y %m" },
        lualine_x = {},
      },
    })
  end,
}
