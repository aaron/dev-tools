local M = {}

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Ruby Split/Join" })
end

local function shiftwidth()
  return vim.bo.shiftwidth > 0 and vim.bo.shiftwidth or vim.bo.tabstop
end

local function split_args(text)
  local args = {}
  local current = {}
  local parens = 0
  local brackets = 0
  local braces = 0
  local quote
  local escaped = false

  for i = 1, #text do
    local char = text:sub(i, i)

    if quote then
      current[#current + 1] = char

      if escaped then
        escaped = false
      elseif char == "\\" then
        escaped = true
      elseif char == quote then
        quote = nil
      end
    else
      if char == '"' or char == "'" then
        quote = char
      elseif char == "(" then
        parens = parens + 1
      elseif char == ")" then
        parens = parens - 1
      elseif char == "[" then
        brackets = brackets + 1
      elseif char == "]" then
        brackets = brackets - 1
      elseif char == "{" then
        braces = braces + 1
      elseif char == "}" then
        braces = braces - 1
      elseif char == "," and parens == 0 and brackets == 0 and braces == 0 then
        args[#args + 1] = vim.trim(table.concat(current))
        current = {}
        goto continue
      end

      current[#current + 1] = char
    end

    ::continue::
  end

  local last_arg = vim.trim(table.concat(current))

  if last_arg ~= "" then
    args[#args + 1] = last_arg
  end

  return args
end

local function call_node_at_cursor()
  if vim.bo.filetype ~= "ruby" then
    notify("This mapping only supports Ruby buffers", vim.log.levels.WARN)
    return nil
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local line = vim.api.nvim_get_current_line()
  local first_nonblank = line:find("%S")

  if not first_nonblank then
    notify("No Ruby call found on this line", vim.log.levels.WARN)
    return nil
  end

  if col < first_nonblank - 1 then
    col = first_nonblank - 1
  end

  local parser = vim.treesitter.get_parser(0, "ruby")
  local tree = parser:parse()[1]
  local root = tree and tree:root()
  local node = root and root:named_descendant_for_range(row, col, row, col)
  local selected

  while node do
    if node:type() == "call" then
      local start_row, _, _, _ = node:range()

      if start_row == row then
        selected = node
      end
    end

    node = node:parent()
  end

  if not selected then
    notify("No Ruby call found at the cursor", vim.log.levels.WARN)
  end

  return selected
end

local function argument_list_node(call_node)
  for child in call_node:iter_children() do
    if child:type() == "argument_list" then
      return child
    end
  end
end

local function replace_node(node, replacement, opts)
  opts = opts or {}

  local start_row, start_col, end_row, end_col = node:range()
  local lines = vim.split(replacement, "\n", { plain = true })

  start_col = opts.start_col or start_col
  end_col = opts.end_col or end_col

  vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
end

function M.split_call()
  local call_node = call_node_at_cursor()

  if not call_node then
    return
  end

  local args_node = argument_list_node(call_node)

  if not args_node then
    notify("No argument list found for this Ruby call", vim.log.levels.WARN)
    return
  end

  local args_text = vim.treesitter.get_node_text(args_node, 0)

  if args_text:find("\n") then
    notify("Call is already split")
    return
  end

  local has_parens = args_text:sub(1, 1) == "(" and args_text:sub(-1) == ")"
  local inner = has_parens and args_text:sub(2, -2) or args_text
  local args = split_args(inner)

  if #args == 0 then
    notify("No arguments found to split", vim.log.levels.WARN)
    return
  end

  local start_row = call_node:range()
  local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
  local base_indent = line:match("^%s*") or ""
  local inner_indent = base_indent .. string.rep(" ", shiftwidth())
  local replacement = "(\n" .. inner_indent .. table.concat(args, ",\n" .. inner_indent) .. "\n" .. base_indent .. ")"

  local replace_opts = {}

  if not has_parens then
    local _, start_col = args_node:range()
    replace_opts.start_col = start_col - 1
  end

  replace_node(args_node, replacement, replace_opts)
end

function M.join_call()
  local call_node = call_node_at_cursor()

  if not call_node then
    return
  end

  local args_node = argument_list_node(call_node)

  if not args_node then
    notify("No argument list found for this Ruby call", vim.log.levels.WARN)
    return
  end

  local args_text = vim.treesitter.get_node_text(args_node, 0)

  if not args_text:find("\n") then
    notify("Call is already joined")
    return
  end

  local has_parens = args_text:sub(1, 1) == "(" and args_text:sub(-1) == ")"
  local inner = has_parens and args_text:sub(2, -2) or args_text
  local args = split_args(inner)

  if #args == 0 then
    notify("No arguments found to join", vim.log.levels.WARN)
    return
  end

  replace_node(args_node, "(" .. table.concat(args, ", ") .. ")")
end

return M
