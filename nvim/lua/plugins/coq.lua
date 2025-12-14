return {
  "ms-jpq/coq_nvim",
  event = "InsertEnter",
  --lazy = false,
  branch = "coq",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
    { "ms-jpq/coq.artifacts" },
    { "ms-jpq/coq.thirdparty" },
    build = ":COQdeps",
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
      keymap = {
        recommended = false,
        --eval_snips = "<leader>e",
        bigger_preview = "<c-w>",
        jump_to_mark = "<c-h>",
      },
    }
  end,
  --opts = {},
  config = function()
    -- we don't want this since we want to use COQ macros etc
    --if vim.b.bigfile then
    --  return
    --end

    local coq = require("coq")
    local map = vim.api.nvim_set_keymap

    --vim.diagnostic.config({ virtual_lines = { current_line = true } })
    vim.diagnostic.config({ virtual_text = false })

    require("coq_3p")({
      {
        -- works only if enclosed in `!foo`
        src = "repl",
        sh = "bash",
        shell = { pl = "perl", n = "node", py = "python" },
        max_lines = 100,
        deadline = 2000,
        short_name = "RUNSH",
        unsafe = { "rm", "mv", "poweroff", "reboot", "sudo" },
      },
      {
        src = "figlet",
        short_name = "BIG",
        trigger = "!big",
        fonts = { "/usr/share/figlet/fonts/standard.flf" },
      },
      {
        -- works only after = at end
        src = "bc",
        short_name = "MATH",
        precision = 6,
      },
      { src = "vim_dadbod_completion", short_name = "DB" },
      --{ src = "copilot", short_name = "COP", accept_key = "<c-f>" },
      --{ src = "codeium", short_name = "COD" },
      -- free self-hosted
      --{ src = "tabby", short_name = "TAB" },
      --{ src = "vimtex", short_name = "vTEX" },
      { src = "nvimlua", short_name = "nLUA", conf_only = true },

      --{ src = "dap" },
    })

    -- COQ these mappings are coq recommended mappings unrelated to nvim-autopairs
    --map('i', '<esc>', [[pumvisible() ? "<c-k><esc>" : "<esc>"]], { expr = true, noremap = true })
    --map('i', '<c-c>', [[pumvisible() ? "<c-k><c-c>" : "<c-c>"]], { expr = true, noremap = true })
    map("i", "<tab>", [[pumvisible() ? "<Down>" : "<tab>"]], { expr = true, noremap = true })
    map("i", "<s-tab>", [[pumvisible() ? "<Up>" : "<bs>"]], { expr = true, noremap = true })
    map(
      "i",
      "<cr>",
      [[pumvisible() ? (complete_info().selected != -1 ? "<c-y>" : "<c-k><esc><cr>") : "<c-k><esc><cr>"]],
      { expr = true, noremap = true }
    )

    local keys = "?!@#$%^&*+-=`\"',./\\:;<>()[]{} "
    for i = 1, #keys do
      local keymap = keys:sub(i, i)
      local key = keymap
      if key == "\\" then
        key = "\\\\"
      elseif key == '"' then
        key = '\\"'
      end

      local pumstring = string.format('(pumvisible() && complete_info().selected != -1) ? "<c-y>%s"  : "%s"', key, key)
      map("i", keymap, pumstring, { expr = true, noremap = true })
    end

    -- autopair + COQ setup
    --local npairs = require('nvim-autopairs')
    --
    --npairs.setup({
    --  disable_in_macro = true,
    --  disable_in_visualblock = true,
    --  check_ts = true,
    --  fast_wrap = {
    --    map = '<C-e>',
    --  },
    --  map_bs = false,
    --  map_cr = false,
    --})
    --
    ---- skip it, if you use another global object
    --_G.MUtils = {}
    --
    --MUtils.CR = function()
    --  if vim.fn.pumvisible() ~= 0 then
    --    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
    --      return npairs.esc('<c-y>')
    --    else
    --      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    --    end
    --  else
    --    return npairs.autopairs_cr()
    --  end
    --end
    --map('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
    --
    --MUtils.BS = function()
    --  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    --    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    --  else
    --    return npairs.autopairs_bs()
    --  end
    --end
    --map('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
  end,
}
