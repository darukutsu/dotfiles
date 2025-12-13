local map = vim.keymap.set
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local finder = function()
    local paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table({
      results = paths,
    })
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = finder(),
      --finder = require("telescope.finders").new_table({
      --  results = file_paths,
      --}),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local state = require("telescope.actions.state")
          local selected_entry = state.get_selected_entry()
          local current_picker = state.get_current_picker(prompt_bufnr)

          table.remove(harpoon_files.items, selected_entry.index)
          current_picker:refresh(finder())
        end)
        return true
      end,
    })
    :find()
end

-- stylua: ignore start
map("n", "<leader>a", function() harpoon:list():add() end, { desc = "harpoon add" })
map("n", "<leader>A", function() harpoon:list():remove() end, { desc = "harpoon remove" })
--map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", "<leader>h", function() toggle_telescope(harpoon:list()) end, { desc = "harpoon telescope" })
map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "harpoon 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "harpoon 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "harpoon 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "harpoon 4" })
map("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "harpoon 5" })
map("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "harpoon 6" })
map("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "harpoon 7" })
map("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "harpoon 8" })
map("n", "<leader>9", function() harpoon:list():select(9) end, { desc = "harpoon 9" })
map("n", "<leader>0", function() harpoon:list():select(10) end, { desc = "harpoon 10" })

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-p>", function() harpoon:list():prev() end)
map("n", "<C-n>", function() harpoon:list():next() end)
-- stylua: ignore end
