return {
  "folke/tokyonight.nvim",
  priority = 1000,
  lazy = false,
  --init = {
  --  vim.opt.termguicolors = true
  --},
  -- Theme
  opts = {
    style = "storm",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = "transparent",
      floats = "transparent",
    },
    sidebars = { "qf", "help" },
    day_brightness = 0.1,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = true,

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    --on_highlights = function(highlights, colors) end,

    -- Borderless Telescope
    --on_highlights = function(hl, c)
    --  local prompt = "#2d3149"
    --  hl.TelescopeNormal = {
    --    bg = c.bg_dark,
    --    fg = c.fg_dark,
    --  }
    --  hl.TelescopeBorder = {
    --    bg = c.bg_dark,
    --    fg = c.bg_dark,
    --  }
    --  hl.TelescopePromptNormal = {
    --    bg = prompt,
    --  }
    --  hl.TelescopePromptBorder = {
    --    bg = prompt,
    --    fg = prompt,
    --  }
    --  hl.TelescopePromptTitle = {
    --    bg = prompt,
    --    fg = prompt,
    --  }
    --  hl.TelescopePreviewTitle = {
    --    bg = c.bg_dark,
    --    fg = c.bg_dark,
    --  }
    --  hl.TelescopeResultsTitle = {
    --    bg = c.bg_dark,
    --    fg = c.bg_dark,
    --  }
    --end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.opt.termguicolors = true
    vim.cmd([[ colorscheme tokyonight-storm ]])
  end,
}
