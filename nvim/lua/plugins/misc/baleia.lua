return {
  "m00qek/baleia.nvim",
  event = "CmdlineEnter",
  ft = { "man", "pager" },
  --lazy = false,
  version = "*",
  config = function()
    vim.g.baleia = require("baleia").setup({
      -- TODO: try again when fixed and displays properly
      --strip_ansi_codes = true,
      --colors = NR_16,
    })

    local buf_name = vim.api.nvim_buf_get_name(0)
    local ft = vim.fn.fnamemodify(buf_name, ":t")
    if ft == "man" or ft == "pager" or buf_name == "" then
      vim.schedule(function()
        vim.opt.modifiable = true

        -- TODO: remove... not sure which one better/faster both ai generated
        --local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        --for i, line in ipairs(lines) do
        --  lines[i] = line:gsub("\x1b%]133;[^\x1b]*\x1b?\\?", ""):gsub("^%]133;[^\x1b]*\x1b?\\?", "")
        --end
        --vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

        if ft == "pager" or buf_name == "" then
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          for i, line in ipairs(lines) do
            lines[i] = line:gsub("\x1b%]133;.-\x1b\\", ""):gsub("^%]133;.-\x1b\\", "")
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        end

        if vim.g.baleia then
          vim.g.baleia.once(0)
        end

        vim.opt.modifiable = false
        vim.opt.modified = false
      end)
    end

    -- Command to colorize the current buffer
    vim.api.nvim_create_user_command("BaleiaColorize", function()
      vim.g.baleia.once(vim.api.nvim_get_current_buf())
    end, { bang = true })

    -- Command to show logs
    vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
  end,
}
