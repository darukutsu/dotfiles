local function loopcommand(args)
  local n = args["fargs"][1]
  local cmd = args["args"]:gsub("^.-%s", "", 1)

  vim.cmd(string.format("for i in range(%s) | execute '%s' | endfor", n, cmd))
end

vim.api.nvim_create_user_command("LoopCmd", loopcommand, { nargs = "+" })
