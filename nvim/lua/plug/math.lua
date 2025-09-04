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

vim.api.nvim_create_user_command("MathTimeSum", MathTimeSum, {})
vim.api.nvim_create_user_command("MathSum", MathSum, {})
vim.api.nvim_create_user_command("MathMul", MathMul, {})
vim.api.nvim_create_user_command("MathDiv", MathDiv, {})
