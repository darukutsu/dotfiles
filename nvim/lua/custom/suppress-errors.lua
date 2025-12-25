local banned = {
  "vscoqtop is deprecated, use vsrocq instead.",
  "copilot is offline",
  "copilot is disabled",
  --"method textDocument/documentColor is not supported by any of the servers registered for the current buffer"
}

local orig = vim.notify
vim.notify = function(msg, ...)
  msg = tostring(msg)
  for _, b in ipairs(banned) do
    if msg:match(b) then
      -- why this does not work?
      return
    end
  end
  return orig(msg, ...)
end
