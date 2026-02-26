vim.lsp.config("jedi_language_server", {
  on_new_config = function(config, root_dir)
    local python
    -- 1. respect an already-activated venv
    local venv = vim.env.VIRTUAL_ENV
    if venv and vim.fn.executable(venv .. "/bin/python3") == 1 then
      python = venv .. "/bin/python3"
    end
    -- 2. fall back to common venv locations inside the project root
    if not python then
      for _, rel in ipairs({ ".venv", "venv", ".env" }) do
        local p = root_dir .. "/" .. rel .. "/bin/python3"
        if vim.fn.executable(p) == 1 then
          python = p
          break
        end
      end
    end
    -- 3. fall back to versioned python on PATH (e.g. python3.10 from AUR)
    if not python then
      for _, candidate in ipairs({ "python3.10", "python3.11", "python3.12" }) do
        if vim.fn.executable(candidate) == 1 then
          python = vim.fn.exepath(candidate)
          break
        end
      end
    end
    if python then
      config.init_options = vim.tbl_deep_extend("force", config.init_options or {}, {
        workspace = { environmentPath = python },
      })
    end
  end,
})
