local function increment_all_numbers_in_selection(sequential, decrement)
  vim.api.nvim_input("<Esc>")
  vim.defer_fn(function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]
    local start_col = start_pos[3]
    local end_col = end_pos[3]
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local row_counter = 0
    for i, line in ipairs(lines) do
      row_counter = 0 -- comment and it will continue incrementing across lines
      local s_col = math.min(start_col, #line)
      local e_col = math.min(end_col, #line)
      local segment = line:sub(s_col, e_col)
      local new_segment = segment:gsub("%-?%d+", function(n)
        if not n:match("%d") then
          return n
        end
        local val = tonumber(n)
        local delta
        if sequential then
          row_counter = row_counter + 1
          delta = row_counter
        else
          delta = 1
        end
        return tostring(decrement and (val - delta) or (val + delta))
      end)
      lines[i] = line:sub(1, s_col - 1) .. new_segment .. line:sub(e_col + 1)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
  end, 0)
end

vim.keymap.set("x", "<C-A-a>", function()
  increment_all_numbers_in_selection(false, false)
end, { desc = "increment num in row" })
vim.keymap.set("x", "g<C-A-a>", function()
  increment_all_numbers_in_selection(true, false)
end, { desc = "increment seq num in row" })
vim.keymap.set("x", "<C-A-x>", function()
  increment_all_numbers_in_selection(false, true)
end, { desc = "decrement num in row" })
vim.keymap.set("x", "g<C-A-x>", function()
  increment_all_numbers_in_selection(true, true)
end, { desc = "decrement seq num in row" })
