---@param args {lhs: string, rhs: fun(), opts?: vim.keymap.set.Opts | {mode: string|string[]}}
---@param getter {name: string, op: fun():boolean}
function SnackMap(args, getter)
  local ok, Snacks = pcall(require, "snacks")
  --print(vim.inspect(Snacks))

  --if not args then
  --  print("empty mapping")
  --  return
  --end

  -- NOTE: define name/desc in snackOpts
  if ok and Snacks then
    Snacks.toggle({
      name = getter.name,
      get = getter.op,
      set = args.rhs,
    }):map(args.lhs, args.opts)
  else
    args.opts = args.opts or {}
    local mode = args.opts.mode or "n"
    args.opts.mode = nil
    args.opts.desc = "Toggle" .. getter.name
    vim.keymap.set(mode, args.lhs, args.rhs, args.opts)
  end
end
