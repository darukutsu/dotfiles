local function keys()
  return {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "harpoon add",
    },
    {
      "<leader>A",
      function()
        require("harpoon"):list():remove()
      end,
      desc = "harpoon remove",
    },
    --{
    --  "<leader>h",
    --  function()
    --    harpoon.ui:toggle_quick_menu(require"harpoon":list())
    --  end,
    --  desc = "harpoon telescope",
    --},
    {
      "<leader>h",
      function()
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
        toggle_telescope(require("harpoon"):list())
      end,
      desc = "harpoon telescope",
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "harpoon 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "harpoon 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "harpoon 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "harpoon 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "harpoon 5",
    },
    {
      "<leader>6",
      function()
        require("harpoon"):list():select(6)
      end,
      desc = "harpoon 6",
    },
    {
      "<leader>7",
      function()
        require("harpoon"):list():select(7)
      end,
      desc = "harpoon 7",
    },
    {
      "<leader>8",
      function()
        require("harpoon"):list():select(8)
      end,
      desc = "harpoon 8",
    },
    {
      "<leader>9",
      function()
        require("harpoon"):list():select(9)
      end,
      desc = "harpoon 9",
    },
    {
      "<leader>0",
      function()
        require("harpoon"):list():select(10)
      end,
      desc = "harpoon 10",
    },
    {
      "<C-n>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "harpoon next",
    },
    {
      "<C-p>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "harpoon prev",
    },
  }
end

-- marks are for jumps within work file harpoon for jumps over work files
return {
  "ThePrimeagen/harpoon",
  --event = "UIEnter",
  -- lazy = false,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = keys,
}
