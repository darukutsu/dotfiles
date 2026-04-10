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
  if not ok or not parser then
    return nil
  end

  local trees = parser:parse()
  if not trees or not trees[1] then
    return nil
  end

  local node = trees[1]:root():named_descendant_for_range(row, col, row, col)
  while node do
    if node:type() == "function_definition" then
      return node
    end
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
      if child:type() == "parameters" then
        pnode = child
        break
      end
    end
  end
  if not pnode then
    return params
  end

  for param in pnode:iter_children() do
    local pt = param:type()
    local name, typ

    if pt == "identifier" then
      name = ntext(param)
    elseif pt == "typed_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" and not name then
          name = ntext(c)
        elseif c:type() == "type" then
          typ = ntext(c)
        end
      end
    elseif pt == "default_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" then
          name = ntext(c)
          break
        end
      end
    elseif pt == "typed_default_parameter" then
      for c in param:iter_children() do
        if c:type() == "identifier" and not name then
          name = ntext(c)
        elseif c:type() == "type" then
          typ = ntext(c)
        end
      end
    elseif pt == "list_splat_pattern" then
      for c in param:iter_children() do
        if c:type() == "identifier" then
          name = "*" .. ntext(c)
          break
        end
      end
    elseif pt == "dictionary_splat_pattern" then
      for c in param:iter_children() do
        if c:type() == "identifier" then
          name = "**" .. ntext(c)
          break
        end
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
  if rt and #rt > 0 then
    return ntext(rt[1])
  end
  for child in func_node:iter_children() do
    if child:type() == "type" then
      return ntext(child)
    end
  end
  return nil
end

--- Build the complete docstring in a single dynamic node so all insert
--- nodes share one contiguous jump list (fixes Tab not reaching later fields).
local function build_full_doc(use_yields)
  return function(_, _)
    local fn = get_function_node()
    local params = fn and extract_params(fn) or {}
    local ret = fn and get_return_type(fn) or nil

    local nodes = {}
    local idx = 1

    -- Summary
    table.insert(nodes, t({ '"""', "" }))
    table.insert(nodes, i(idx, "A one-line summary."))
    idx = idx + 1

    -- Description
    table.insert(nodes, t({ "", "", "" }))
    table.insert(nodes, i(idx, "Detailed description."))
    idx = idx + 1

    -- Args
    if #params == 0 then
      table.insert(nodes, t({ "", "", "Args:", "    " }))
      table.insert(nodes, i(idx, "argument_name"))
      idx = idx + 1
      table.insert(nodes, t(": "))
      table.insert(nodes, i(idx, "type and description."))
      idx = idx + 1
    else
      table.insert(nodes, t({ "", "", "Args:" }))
      for _, p in ipairs(params) do
        local label = p.type and (p.name .. " (" .. p.type .. ")") or p.name
        table.insert(nodes, t({ "", "    " .. label .. ": " }))
        table.insert(nodes, i(idx, "description."))
        idx = idx + 1
      end
    end

    -- Returns / Yields
    local section = use_yields and "Yields" or "Returns"
    if ret and ret ~= "None" then
      table.insert(nodes, t({ "", "", section .. ":", "    " .. ret .. ": " }))
      table.insert(
        nodes,
        i(idx, use_yields and "description of the yielded object." or "description of the returned object.")
      )
      idx = idx + 1
    else
      table.insert(nodes, t({ "", "", section .. ":", "    " }))
      table.insert(
        nodes,
        i(
          idx,
          use_yields and "type and description of the yielded object." or "type and description of the returned object."
        )
      )
      idx = idx + 1
    end

    -- Example
    table.insert(nodes, t({ "", "", "Example:", "    # " }))
    table.insert(nodes, i(idx, "Description of my example."))
    idx = idx + 1
    table.insert(nodes, t({ "", "    " }))
    table.insert(nodes, i(idx, "use_it_this_way(arg1, arg2)"))

    -- Close
    table.insert(nodes, t({ "", '"""' }))

    return sn(nil, nodes)
  end
end

local function build_pydoc_fn()
  return function(_, _)
    local fn = get_function_node()
    local params = fn and extract_params(fn) or {}

    local nodes = {}
    local idx = 1

    -- Summary
    table.insert(nodes, t({ '"""', "" }))
    table.insert(nodes, i(idx, "Description..."))
    idx = idx + 1

    -- Args
    if #params == 0 then
      table.insert(nodes, t({ "", "", "Args:", "    " }))
      table.insert(nodes, i(idx, "argument_name"))
      idx = idx + 1
      table.insert(nodes, t(": "))
      table.insert(nodes, i(idx, "type and description."))
      idx = idx + 1
    else
      table.insert(nodes, t({ "", "", "Args:" }))
      for _, p in ipairs(params) do
        local label = p.type and (p.name .. " (" .. p.type .. ")") or p.name
        table.insert(nodes, t({ "", "    " .. label .. ": " }))
        table.insert(nodes, i(idx, "description."))
        idx = idx + 1
      end
    end

    -- Close
    table.insert(nodes, t({ "", '"""' }))

    return sn(nil, nodes)
  end
end

local function build_pydoc_fn_ret(use_yields)
  return function(_, _)
    local fn = get_function_node()
    local params = fn and extract_params(fn) or {}
    local ret = fn and get_return_type(fn) or nil

    local nodes = {}
    local idx = 1

    -- Summary
    table.insert(nodes, t({ '"""', "" }))
    table.insert(nodes, i(idx, "Description..."))
    idx = idx + 1

    -- Args
    if #params == 0 then
      table.insert(nodes, t({ "", "", "Args:", "    " }))
      table.insert(nodes, i(idx, "argument_name"))
      idx = idx + 1
      table.insert(nodes, t(": "))
      table.insert(nodes, i(idx, "type and description."))
      idx = idx + 1
    else
      table.insert(nodes, t({ "", "", "Args:" }))
      for _, p in ipairs(params) do
        local label = p.type and (p.name .. " (" .. p.type .. ")") or p.name
        table.insert(nodes, t({ "", "    " .. label .. ": " }))
        table.insert(nodes, i(idx, "description."))
        idx = idx + 1
      end
    end

    -- Returns / Yields
    local section = use_yields and "Yields" or "Returns"
    if ret and ret ~= "None" then
      table.insert(nodes, t({ "", "", section .. ":", "    " .. ret .. ": " }))
      table.insert(
        nodes,
        i(idx, use_yields and "description of the yielded object." or "description of the returned object.")
      )
      idx = idx + 1
    else
      table.insert(nodes, t({ "", "", section .. ":", "    " }))
      table.insert(
        nodes,
        i(
          idx,
          use_yields and "type and description of the yielded object." or "type and description of the returned object."
        )
      )
      idx = idx + 1
    end

    -- Close
    table.insert(nodes, t({ "", '"""' }))

    return sn(nil, nodes)
  end
end

-- priority 1001 to override friendly-snippets (default 1000)
return {
  s({
    trig = "###",
    priority = 1001,
    dscr = "Function docstring (auto args)",
  }, { d(1, build_full_doc(false), {}) }),

  s({
    trig = "###fn_typed",
    priority = 1001,
    dscr = "Function docstring (auto args)",
  }, { d(1, build_pydoc_fn(false), {}) }),

  s({
    trig = "###fn_ret_typed",
    priority = 1001,
    dscr = "Function docstring (auto args)",
  }, { d(1, build_pydoc_fn_ret(false), {}) }),

  s({
    trig = "###function_typed",
    priority = 1001,
    dscr = "Function docstring typed (auto args) + return & example",
  }, { d(1, build_full_doc(false), {}) }),

  s({
    trig = "###generator",
    priority = 1001,
    dscr = "Generator docstring (auto args)",
  }, { d(1, build_full_doc(true), {}) }),
}
