-- edited denialofsandwich/sudo.nvim
local M = {}

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

-- Stolen from: https://github.com/MunifTanjim/nui.nvim/wiki/nui.input
local SecretInput = Input:extend("SecretInput")

function SecretInput:init(popup_options, options)
  assert(
    not options.conceal_char or vim.api.nvim_strwidth(options.conceal_char) == 1,
    "conceal_char must be a single char"
  )

  popup_options.win_options = vim.tbl_deep_extend("force", popup_options.win_options or {}, {
    conceallevel = 2,
    concealcursor = "nvi",
  })

  SecretInput.super.init(self, popup_options, options)

  self._.conceal_char = type(options.conceal_char) == "nil" and "*" or options.conceal_char
end

function SecretInput:mount()
  SecretInput.super.mount(self)

  local conceal_char = self._.conceal_char
  local prompt_length = vim.api.nvim_strwidth(vim.fn.prompt_getprompt(self.bufnr))

  vim.api.nvim_buf_call(self.bufnr, function()
    vim.cmd(string.format(
      [[
        syn region SecretValue start=/^/ms=s+%s end=/$/ contains=SecretChar
        syn match SecretChar /./ contained conceal %s
      ]],
      prompt_length,
      conceal_char and "cchar=" .. (conceal_char or "*") or ""
    ))
  end)
end

--- @param title string
--- @param on_submit fun(value: string)
M.ask_password = function(title, on_submit)
  title = title or "Password"

  local input = SecretInput({
    position = "50%",
    size = {
      width = 30,
    },
    border = {
      style = "single",
      text = {
        top = title,
        top_align = "center",
      },
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_submit = on_submit,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

--- @param cmd string
--- @param callback fun(jobid: number, data: table, event: string)
M.sudo_run = function(cmd, callback)
  local attempt = 0
  local password_correct = false
  local on_event = function(jobid, data, event)
    vim.cmd("startinsert")
    if event == "stderr" and data[1] == "enter_password" then
      attempt = attempt + 1
      M.ask_password("Password (Attempt: " .. attempt .. ")", function(password)
        vim.fn.chansend(jobid, { password, "" })
      end)
    elseif event == "stderr" and string.find(data[1], "incorrect password") then
      print("Too many failed attempts")
    elseif event == "stdout" and data[1] == "password_correct" then
      password_correct = true
    end

    if password_correct == true then
      callback(jobid, data, event)
    end
    vim.cmd("stopinsert")
  end

  vim.fn.jobstart('sudo -S -p enter_password -- bash -c "echo password_correct ; ' .. cmd .. '"', {
    cwd = vim.fn.getcwd(),
    on_exit = on_event,
    on_stdout = on_event,
    on_stderr = on_event,
  })
end

--- @param opts string
M.buffer_write = function(opts)
  local path = opts.args ~= "" and opts.args or vim.api.nvim_buf_get_name(0)
  M.sudo_run("cat > " .. path, function(jobid, data, event)
    if event == "stdout" and data[1] == "password_correct" then
      local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      table.insert(content, "")

      vim.fn.chansend(jobid, content)
      vim.fn.chanclose(jobid, "stdin")
    elseif event == "exit" and data == 0 then
      vim.cmd("edit! " .. path)
    end
  end)
end

--- @param opts string
M.buffer_read = function(opts)
  local path = opts.args ~= "" and opts.args or nil
  local ready_to_read = false
  M.sudo_run("cat " .. path, function(jobid, data, event)
    if event == "stdout" and data[1] == "password_correct" then
      ready_to_read = true
    elseif ready_to_read then
      ready_to_read = false
      table.remove(data, #data)

      local buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_buf_set_name(buf, path)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
      vim.api.nvim_set_option_value("modified", false, { buf = buf })
      vim.api.nvim_set_current_buf(buf)
    end
  end)
end

vim.api.nvim_create_user_command("SudoWrite", M.buffer_write, { nargs = 0 })
vim.api.nvim_create_user_command("SW", M.buffer_write, { nargs = 0 })
vim.api.nvim_create_user_command("SudoRead", M.buffer_read, { nargs = 1 })
vim.api.nvim_create_user_command("SR", M.buffer_read, { nargs = 1 })
