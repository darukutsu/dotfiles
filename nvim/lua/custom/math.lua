local function MathTimeSum(args)
  vim.cmd(
    ":'<,'>!xargs -I{} date +\\%s --date '1970-1-1 {}' \\| awk '{sum += ($1+3600)} END {printf \"\\%.2d:\\%.2d:\\%.2d\", sum/3600, (sum\\%3600)/60, sum\\%60}'"
  )
end
local function MathSum(args)
  vim.cmd(":!xclip -d ':0' -selection clipboard -o | sed 's/$/\\+/' | tr -d '\\n ' | sed 's/$/0\\n/' | bc")
end
local function MathMul(args)
  vim.cmd(":!xclip -d ':0' -selection clipboard -o | sed 's/$/*/' | tr -d '\\n ' | sed 's/$/1\\n/' | bc")
end
local function MathDiv(args)
  vim.cmd(":!xclip -d ':0' -selection clipboard -o | sed 's/$/\\//' | tr -d '\\n ' | sed 's/$/1\\n/' | bc")
end

vim.api.nvim_create_user_command("MathEval", function()
  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")

  local first = math.min(s[3], e[3])
  local last = math.max(s[3], e[3])

  local line = vim.api.nvim_buf_get_lines(0, s[2] - 1, s[2], false)[1]
  local expr = line:sub(first, last)

  vim.notify("Expression: [" .. expr .. "]")

  local result = vim.fn.system("echo '" .. expr .. "' | bc")
  if vim.v.shell_error ~= 0 then
    vim.notify("bc error: " .. result, vim.log.levels.ERROR)
    return
  end

  vim.api.nvim_buf_set_text(0, s[2] - 1, first - 1, s[2] - 1, last, { vim.trim(result) })
end, { range = true })
vim.api.nvim_create_user_command("MathTimeSum", MathTimeSum, {})
vim.api.nvim_create_user_command("MathSum", MathSum, {})
vim.api.nvim_create_user_command("MathMul", MathMul, {})
vim.api.nvim_create_user_command("MathDiv", MathDiv, {})
