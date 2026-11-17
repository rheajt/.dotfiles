local open_opencode, context, select_prompt

vim.keymap.set('n', '<leader>ao', function() open_opencode() end, {
  silent = true,
  desc = '[A]I [O]penCode in right Herdr split',
})

vim.keymap.set('n', '<leader>af', function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    vim.notify('Save the buffer before sending its filename', vim.log.levels.WARN)
    return
  end
  open_opencode('@' .. vim.fn.fnamemodify(path, ':.'))
end, { desc = 'Send Filename to Herdr OpenCode' })

vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() select_prompt() end, {
  desc = '[A]I [P]rompt for context',
})

vim.keymap.set('x', '<leader>av', function()
  -- Read the live anchor/cursor before asynchronous work, not previous selection marks.
  local anchor, cursor = vim.fn.getpos 'v', vim.fn.getpos '.'
  local mode = vim.fn.mode()
  local lines = vim.fn.getregion(anchor, cursor, {
    type = mode,
    exclusive = vim.o.selection == 'exclusive',
  })
  local range = string.format(' (lines %d-%d)', math.min(anchor[2], cursor[2]), math.max(anchor[2], cursor[2]))
  open_opencode(context(table.concat(lines, '\n'), range))
end, { desc = 'Send Visual Selefction to Herdr OpenCode' })

local busy = false

local function diagnostic_lines(diagnostics, path_for_buffer)
  local lines = {}
  for _, diagnostic in ipairs(diagnostics) do
    local details = {}
    if diagnostic.source then details[#details + 1] = tostring(diagnostic.source) end
    if diagnostic.code then details[#details + 1] = tostring(diagnostic.code) end
    local severity = vim.diagnostic.severity[diagnostic.severity] or 'UNKNOWN'
    lines[#lines + 1] = string.format('%s:%d:%d [%s]%s %s',
      path_for_buffer(diagnostic.bufnr), (diagnostic.lnum or 0) + 1,
      (diagnostic.col or 0) + 1, severity,
      #details > 0 and ' (' .. table.concat(details, ', ') .. ')' or '',
      tostring(diagnostic.message or ''))
  end
  return lines
end

local function diagnostics_prompt(bufnr, path)
  local diagnostics = vim.diagnostic.get(bufnr)
  if #diagnostics == 0 then
    vim.notify('No diagnostics in the current file', vim.log.levels.INFO)
    return
  end
  return table.concat(diagnostic_lines(diagnostics, function() return '@' .. path end), '\n')
end

local prompts = {
  { label = 'changes: Review Git changes', kind = 'changes' },
  { label = 'diagnostics: Fix file diagnostics', kind = 'diagnostics' },
  { label = 'diagnostics_all: Fix all diagnostics', kind = 'diagnostics_all' },
  { label = 'document: Add documentation', kind = 'document' },
  { label = 'explain: Explain context', kind = 'explain' },
  { label = 'fix: Fix context', kind = 'fix' },
  { label = 'optimize: Optimize context', kind = 'optimize' },
  { label = 'review: Review file', kind = 'review' },
  { label = 'tests: Write tests', kind = 'tests' },
  { label = 'quickfix: Use quickfix entries', kind = 'quickfix' },
}

local function file_path(path, cwd)
  if path == '' then return nil end
  local candidate = path:sub(1, 1) == '/' and path or (cwd:gsub('/+$', '') .. '/' .. path)
  local absolute = vim.fn.fnamemodify(candidate, ':p')
  local root = vim.fn.fnamemodify(cwd, ':p'):gsub('/+$', '')
  if absolute:sub(1, #root + 1) == root .. '/' then
    return absolute:sub(#root + 2)
  end
  return absolute
end

local function context_location(origin)
  return string.format('@%s:%d:%d', origin.file, origin.line, origin.column)
end

local function diagnostics_all_prompt(cwd)
  local diagnostics = vim.diagnostic.get()
  if #diagnostics == 0 then
    vim.notify('No diagnostics are currently available', vim.log.levels.INFO)
    return
  end
  return 'Can you help me fix these diagnostics?\n'
    .. table.concat(diagnostic_lines(diagnostics, function(bufnr)
      if type(bufnr) ~= 'number' or not vim.api.nvim_buf_is_valid(bufnr) then return '[unknown buffer]' end
      local path = file_path(vim.api.nvim_buf_get_name(bufnr), cwd)
      return path and '@' .. path or '[unnamed buffer]'
    end), '\n')
end

local function quickfix_prompt(cwd)
  local entries = vim.fn.getqflist({ items = 1, context = 0 }).items or {}
  if #entries == 0 then
    vim.notify('Quickfix list is empty', vim.log.levels.INFO)
    return
  end
  local lines = {}
  for _, entry in ipairs(entries) do
    local valid_buf = type(entry.bufnr) == 'number' and entry.bufnr > 0
      and vim.api.nvim_buf_is_valid(entry.bufnr)
    local name = valid_buf and vim.api.nvim_buf_get_name(entry.bufnr) or ''
    local filename = type(entry.filename) == 'string' and file_path(entry.filename, cwd)
      or (name ~= '' and file_path(name, cwd))
    local location = filename and (filename .. ':' .. (entry.lnum or 0) .. ':' .. (entry.col or 0))
      or (entry.lnum and entry.lnum > 0 and (':' .. entry.lnum .. ':' .. (entry.col or 0)) or '')
    local kind = entry.type and entry.type ~= '' and (' [' .. entry.type .. ']') or ''
    lines[#lines + 1] = (location or '[quickfix entry]') .. kind .. ' ' .. (entry.text or '')
  end
  return table.concat(lines, '\n')
end

select_prompt = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local raw_path = vim.api.nvim_buf_get_name(bufnr)
  local cwd = vim.fn.getcwd()
  local position = vim.api.nvim_win_get_cursor(0)
  local mode = vim.fn.mode()
  local origin = {
    bufnr = bufnr, cwd = cwd, file = file_path(raw_path, cwd),
    line = position[1], column = position[2] + 1,
  }
  if mode:sub(1, 1) == 'v' or mode:sub(1, 1) == 'V' or mode:byte(1) == 22 then
    local anchor, cursor = vim.fn.getpos('v'), vim.fn.getpos('.')
    local first, last = anchor, cursor
    if anchor[2] > cursor[2] or (anchor[2] == cursor[2] and anchor[3] > cursor[3]) then
      first, last = cursor, anchor
    end
    origin.selection_start = { line = first[2], column = first[3] }
    origin.selection_end = { line = last[2], column = last[3] }
    origin.selection = table.concat(vim.fn.getregion(anchor, cursor, {
      type = mode, exclusive = vim.o.selection == 'exclusive',
    }), '\n')
  else
    origin.selection = vim.api.nvim_buf_get_lines(bufnr, position[1] - 1, position[1], false)[1] or ''
  end
  local labels = vim.tbl_map(function(prompt) return prompt.label end, prompts)
  vim.ui.select(labels, { prompt = 'Choose a prompt' }, function(choice)
    if not choice then return end
    for _, prompt in ipairs(prompts) do
      if prompt.label == choice or prompt == choice then
        local kind = prompt.kind
        local function send(payload)
          if payload and payload ~= '' then open_opencode(payload) end
        end
        if kind == 'changes' then
          if vim.fn.executable('git') ~= 1 then
            vim.notify('Git must be on PATH to review changes', vim.log.levels.ERROR)
            return
          end
          local results, pending = {}, 2
          local function done(index, result)
            results[index] = result
            pending = pending - 1
            if pending ~= 0 then return end
            if results[1].code ~= 0 or results[2].code ~= 0 then
              local failed = results[1].code ~= 0 and results[1] or results[2]
              local stderr = failed.stderr and failed.stderr:gsub('%s+$', '')
              vim.notify('Cannot read Git changes: '
                .. (stderr and stderr ~= '' and stderr or 'Git command failed'), vim.log.levels.ERROR)
              return
            end
            local sections = {}
            if results[1].code == 0 and results[1].stdout ~= '' then
              sections[#sections + 1] = 'Staged changes:\n' .. results[1].stdout
            end
            if results[2].code == 0 and results[2].stdout ~= '' then
              sections[#sections + 1] = 'Unstaged changes:\n' .. results[2].stdout
            end
            if #sections == 0 then
              vim.notify('No tracked Git changes to review', vim.log.levels.INFO)
              return
            end
            send('Can you review my changes?\n' .. table.concat(sections, '\n\n'))
          end
          for index, args in ipairs({
            { 'diff', '--cached', '--no-ext-diff', '--no-textconv', '--no-color', '--' },
            { 'diff', '--no-ext-diff', '--no-textconv', '--no-color', '--' },
          }) do
            local ok, err = pcall(vim.system, vim.list_extend({ 'git' }, args), { cwd = cwd, text = true },
              function(result) vim.schedule(function() done(index, result) end) end)
            if not ok then
              vim.schedule(function()
                done(index, { code = 1, stderr = tostring(err), stdout = '' })
              end)
            end
          end
          return
        elseif kind == 'diagnostics_all' then
          local diagnostics = diagnostics_all_prompt(cwd)
          if diagnostics then send(diagnostics) end
        elseif kind == 'quickfix' then
          local entries = quickfix_prompt(cwd)
          if entries then send(entries .. ' (current quickfix entries)') end
        elseif kind == 'diagnostics' then
          if not origin.file then
            vim.notify('Save the buffer before requesting file diagnostics', vim.log.levels.WARN)
            return
          end
          local diagnostics = diagnostics_prompt(bufnr, origin.file)
          if diagnostics then send('Can you help me fix the diagnostics in @' .. origin.file .. '?\n' .. diagnostics) end
        else
          if not origin.file then
            vim.notify('Save the buffer before using this file prompt', vim.log.levels.WARN)
            return
          end
          local location = context_location(origin)
          local selected_location = location
          if origin.selection_start then
            selected_location = string.format('@%s:%d:%d-@%s:%d:%d', origin.file,
              origin.selection_start.line, origin.selection_start.column, origin.file,
              origin.selection_end.line, origin.selection_end.column)
          end
          local context_text = origin.selection .. '\n(' .. selected_location .. ')'
          local text = ({
            document = 'Add documentation to ' .. location,
            explain = 'Explain ' .. context_text,
            fix = 'Can you fix ' .. context_text .. '?',
            optimize = 'How can ' .. context_text .. ' be optimized?',
            review = 'Can you review @' .. origin.file .. ' for any issues or improvements?',
            tests = 'Can you write tests for ' .. context_text .. '?',
          })[kind]
          send(text)
        end
        return
      end
    end
  end)
end

local function basename(path) return type(path) == 'string' and path:match '([^/]+)$' or '' end

local function executable_name(process)
  local argv = type(process.argv) == 'table' and process.argv or {}
  for _, value in ipairs { argv[1] or '', process.argv0 or '', process.name or '' } do
    local name = basename(value)
    if name ~= '' then return name end
  end
  return ''
end

local function is_opencode(process)
  local executable = executable_name(process)
  if executable == 'opencode' then return true end
  -- Script installations expose the interpreter as the executable.
  return (executable == 'bun' or executable == 'node') and type(process.argv) == 'table' and basename(process.argv[2]) == 'opencode'
end

open_opencode = function(payload)
  if busy then
    vim.notify('Herdr OpenCode operation already in progress', vim.log.levels.WARN)
    return
  end
  if vim.fn.executable 'herdr' ~= 1 or vim.fn.executable 'opencode' ~= 1 then
    vim.notify('herdr and opencode must be on PATH', vim.log.levels.ERROR)
    return
  end
  if vim.env.HERDR_ENV ~= '1' then
    vim.notify('OpenCode split requires Neovim to be running inside Herdr', vim.log.levels.ERROR)
    return
  end
  if payload and payload:find '[%z\1-\8\11-\31\127]' then
    vim.notify('Context contains unsafe control characters', vim.log.levels.ERROR)
    return
  end

  busy = true
  local cwd = vim.fn.getcwd()
  local thread
  local function resume(...)
    local ok, err = coroutine.resume(thread, ...)
    if not ok then
      busy = false
      vim.notify('Herdr OpenCode: ' .. tostring(err), vim.log.levels.ERROR)
    elseif coroutine.status(thread) == 'dead' then
      busy = false
    end
  end
  local function request(args, status_only)
    local command = { 'herdr' }
    vim.list_extend(command, args)
    vim.system(command, { text = true }, function(result)
      vim.schedule(function() resume(result) end)
    end)
    local result = coroutine.yield()
    if result.code ~= 0 then error(result.stderr or 'Herdr command failed', 0) end
    if status_only then return end
    local ok, response = pcall(vim.json.decode, result.stdout or '')
    if not ok or type(response) ~= 'table' or type(response.result) ~= 'table' then
      error('Invalid Herdr JSON response from ' .. args[1] .. ' ' .. args[2], 0)
    end
    return response.result
  end

  thread = coroutine.create(function()
    local neighbor = request({ 'pane', 'neighbor', '--direction', 'right', '--current' }).neighbor
    if type(neighbor) ~= 'table' then error('Missing Herdr neighbor response', 0) end
    local pane_id = neighbor.neighbor_pane_id
    if pane_id == nil or pane_id == vim.NIL then
      local pane = request({
        'pane',
        'split',
        '--current',
        '--direction',
        'right',
        '--cwd',
        cwd,
        '--no-focus',
      }).pane
      pane_id = type(pane) == 'table' and pane.pane_id
    end
    if type(pane_id) ~= 'string' or pane_id == '' then error('Missing Herdr pane ID', 0) end

    local info = request({ 'pane', 'process-info', '--pane', pane_id }).process_info
    if type(info) ~= 'table' or type(info.foreground_processes) ~= 'table' then error('Cannot identify right pane foreground process', 0) end
    local opencode, shell = false, false
    for _, process in ipairs(info.foreground_processes) do
      if type(process) == 'table' then
        opencode = opencode or is_opencode(process)
        local name = executable_name(process):gsub('^%-', '')
        shell = shell or (process.pid == info.shell_pid and vim.tbl_contains({ 'sh', 'bash', 'zsh', 'fish', 'dash', 'ksh', 'nu' }, name))
      end
    end
    if not opencode then
      if not shell or not info.shell_pid or info.foreground_process_group_id ~= info.shell_pid then
        error('Right pane is occupied or unknown; refusing to send input', 0)
      end
      -- Herdr waits for readiness; a failure must not be retried automatically.
      local name = 'nvim_oc_' .. tostring(vim.uv.hrtime()):gsub('%D', ''):sub(-20)
      request { 'agent', 'start', name, '--kind', 'opencode', '--pane', pane_id, '--timeout', '30000', '--', cwd }
    else
      local agent = request({ 'agent', 'get', pane_id }).agent
      if
        type(agent) ~= 'table'
        or agent.agent ~= 'opencode'
        or agent.launch_pending == true
        or agent.interactive_ready == false
        or not vim.tbl_contains({ 'idle', 'done' }, agent.agent_status)
      then
        error('Right OpenCode pane is not ready for input', 0)
      end
    end
    if payload then request({ 'pane', 'send-text', pane_id, '\27[200~' .. payload .. '\27[201~' }, true) end
    request({ 'agent', 'focus', pane_id }, true)
  end)
  resume()
end

context = function(text, range)
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then path = '[unnamed buffer]' end
  return 'Context from file: ' .. path .. (range or '') .. '\n\n' .. '```\n' .. text .. '\n```'
end
