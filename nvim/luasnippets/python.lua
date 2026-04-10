-- Dynamic pydoc snippets with Treesitter-based arg/return expansion
-- Overrides friendly-snippets pydoc triggers: ###, ###function, ###function_typed, ###generator

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

local function ntext(node)
  return vim.treesitter.get_node_text(node, 0)
end

--- Walk up the Treesitter tree from cursor to find the enclosing function_definition
local function get_function_node()
  local buf = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local col = vim.api.nvim_win_get_cursor(0)[2]

  local ok, parser = pcall(vim.treesitter.get_parser, buf, "python")
  if not ok or not parser then return nil end

  local trees = parser:parse()
  if not trees or not trees[1] then return nil end

  local node = trees[1]:root():named_descendant_for_range(row, col, row, col)
  while node do
    if node:type() == "function_definition" then return node end
    node = node:parent()
  end
  return nil
end

--- Extract parameters from a function_definition node
local function extract_params(func_node)
  local params = {}

  -- Find parameters node (field access with fallback)
  local pnode
  local pfield = func_node:field("parameters")
  if pfield and #pfield > 0 then
    pnode = pfield[1]
  else
    for child in func_node:iter_children() do
      if child:type() == "parameters" then pnode = child; break end
    end
  end
  if not pnode then return params end

  for param in pnode:iter_children() do
    local pt = param:type()
    local name, typ

    if pt == "identifier" then
      name = ntext(param)

    elseif pt == "typed_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" and not name then name = ntext(c)
        elseif c:type() == "type" then typ = ntext(c) end
      end

    elseif pt == "default_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" then name = ntext(c); break end
      end

    elseif pt == "typed_default_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" and not name then name = ntext(c)
        elseif c:type() == "type" then typ = ntext(c) end
      end

    elseif pt == "list_splat_pattern" then
      for c in param:iter_children() do
        if c:type() == "identifier" then name = "*" .. ntext(c); break end
      end

    elseif pt == "dictionary_splat_pattern" then
      for c in param:iter_children() do
        if c:type() == "identifier" then name = "**" .. ntext(c); break end
      end
    end

    if name and name ~= "self" and name ~= "cls" then
      table.insert(params, { name = name, type = typ })
    end
  end
  return params
end

--- Extract return type annotation from function_definition node
local function get_return_type(func_node)
  local rt = func_node:field("return_type")
  if rt and #rt > 0 then return ntext(rt[1]) end
  for child in func_node:iter_children() do
    if child:type() == "type" then return ntext(child) end
  end
  return nil
end

--- Dynamic node: builds the Args section from function parameters
local function build_args(_, _)
  local fn = get_function_node()
  local params = fn and extract_params(fn) or {}

  if #params == 0 then
    return sn(nil, {
      t({ "", "", "Args:", "    " }),
      i(1, "argument_name"),
      t(": "),
      i(2, "type and description."),
    })
  end

  local nodes = { t({ "", "", "Args:" }) }
  for idx, p in ipairs(params) do
    local label = p.type and (p.name .. " (" .. p.type .. ")") or p.name
    table.insert(nodes, t({ "", "    " .. label .. ": " }))
    table.insert(nodes, i(idx, "description."))
  end
  return sn(nil, nodes)
end

--- Dynamic node: builds the Returns section with auto-detected return type
local function build_returns(_, _)
  local fn = get_function_node()
  local ret = fn and get_return_type(fn)

  if ret and ret ~= "None" then
    return sn(nil, {
      t({ "", "", "Returns:", "    " .. ret .. ": " }),
      i(1, "description of the returned object."),
    })
  end
  return sn(nil, {
    t({ "", "", "Returns:", "    " }),
    i(1, "type and description of the returned object."),
  })
end

--- Dynamic node: builds the Yields section (for generators)
local function build_yields(_, _)
  local fn = get_function_node()
  local ret = fn and get_return_type(fn)

  if ret and ret ~= "None" then
    return sn(nil, {
      t({ "", "", "Yields:", "    " .. ret .. ": " }),
      i(1, "description of the yielded object."),
    })
  end
  return sn(nil, {
    t({ "", "", "Yields:", "    " }),
    i(1, "type and description of the yielded object."),
  })
end

--- Build the full docstring node list
local function make_func_doc(args_fn, returns_fn)
  return {
    t({ '"""', "" }),
    i(1, "A one-line summary."),
    t({ "", "", "" }),
    i(2, "Detailed description."),
    d(3, args_fn, {}),
    d(4, returns_fn, {}),
    t({ "", "", "Example:", "    # " }),
    i(5, "Description of my example."),
    t({ "", "    " }),
    i(6, "use_it_this_way(arg1, arg2)"),
    t({ "", '"""' }),
  }
end

-- priority 1001 to override friendly-snippets (default 1000)
return {
  s({ trig = "###", priority = 1001, dscr = "Function docstring (auto args)" },
    make_func_doc(build_args, build_returns)),

  s({ trig = "###function", priority = 1001, dscr = "Function docstring (auto args)" },
    make_func_doc(build_args, build_returns)),

  s({ trig = "###function_typed", priority = 1001, dscr = "Function docstring typed (auto args)" },
    make_func_doc(build_args, build_returns)),

  s({ trig = "###generator", priority = 1001, dscr = "Generator docstring (auto args)" },
    make_func_doc(build_args, build_yields)),
}
