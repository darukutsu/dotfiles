return {
  "cursortab/cursortab.nvim",
  lazy = false, -- The server is already lazy loaded
  build = "cd server && go build",
  config = function()
    require("cursortab").setup({
      provider = {
        -- TODO: make this runtime decidable
        -- curl http://ollama.ai.lan/api/ps
        --type = "zeta-2",
        -- model = "gemma4",
        type = "sweep",
        model = "sweepai/sweep-next-edit:latest",
        url = "http://ollama.ai.lan",
        --api_key_env = "",
        completion_path = "/v1/completions",
        privacy_mode = true,
      },
      keymaps = {
        accept = "<C-tab>",
        partial_accept = "<C-S-tab>",
        trigger = "<C-t>",
      },
      --blink = {
      --  enabled = true,
      --  ghost_text = false,
      --},
      ui = {
        completions = {
          addition_style = "dimmed",
          fg_opacity = 0.6,
        },
        jump = {
          symbol = "",
          text = "<C-tab>",
          show_distance = true,
        },
      },
      behavior = {
        ignore_gitignored = false,
      },
      contribute_data = false,
    })
  end,
}
