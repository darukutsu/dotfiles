-- nvim/lua/plugins/themes/baleia.lua
return {
  "m00qek/baleia.nvim",
  cmd = "BaleiaColorize",
  ft = { "man", "pager" },
  lazy = false,
  version = "*",
  config = function()
    local baleia = require("baleia").setup({})
    vim.g.baleia = baleia

    vim.api.nvim_create_autocmd({ "StdinReadPost" }, {
      callback = function()
        vim.defer_fn(function()
          local bufnr = vim.api.nvim_get_current_buf()

          vim.bo[bufnr].filetype = "pager"
          vim.opt.modifiable = true

          -- Clean up OSC sequences only (keep SGR/color codes)
          local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
          local cleaned = {}
          for _, line in ipairs(lines) do
            -- Remove OSC sequences but KEEP SGR sequences (ESC[...m)
            local clean = line:gsub("\x1b%].-\x1b\\", "")
            clean = clean:gsub("\x1b%][^\x1b]*\x07", "")
            clean = clean:gsub("^%][^\x1b]*\x1b\\", "")
            table.insert(cleaned, clean)
          end
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, cleaned)

          -- Colorize the buffer content
          baleia.buf_set_lines(bufnr, 0, -1, false, cleaned)

          vim.opt.modifiable = false
          vim.opt.modified = false

          print("Baleia colorized buffer " .. bufnr)
        end, 100)
      end,
    })

    vim.api.nvim_create_user_command("BaleiaColorize", function()
      vim.opt.modifiable = true
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      baleia.buf_set_lines(bufnr, 0, -1, false, lines)
      vim.opt.modifiable = false
      print("Manual baleia colorization done")
    end, { bang = true })

    vim.api.nvim_create_user_command("BaleiaLogs", function()
      baleia.logger.show()
    end, { bang = true })
  end,
}
