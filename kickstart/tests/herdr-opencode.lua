-- Run from the repository root: nvim --headless -u NONE -l kickstart/tests/herdr-opencode.lua
-- All Herdr commands are mocked; no panes are created or modified.
local plugin = 'kickstart/lua/custom/plugins/herdr-opencode.lua'
local failures = {}

-- Keep test overrides off Neovim's shared API tables (including LuaLS's inferred types).
-- rawset installs runtime-only overrides without declaring replacement API signatures.
local vim = setmetatable({
    api = setmetatable({}, { __index = vim.api }),
    fn = setmetatable({}, { __index = vim.fn }),
    keymap = setmetatable({}, { __index = vim.keymap }),
    ui = setmetatable({}, { __index = vim.ui }),
    diagnostic = setmetatable({}, { __index = vim.diagnostic }),
    env = setmetatable({}, { __index = vim.env }),
}, { __index = vim })

local function load_plugin()
    assert(loadfile(plugin, 't', setmetatable({ vim = vim }, { __index = _G })))()
end

local function check(name, process, expected, options)
    options = options or {}
    local mappings, commands, notices, levels = {}, {}, {}, {}
    local contents_read = false
    local path = options.path or vim.fn.getcwd() .. '/example file.lua'
    local original = {
        system = vim.system,
        notify = vim.notify,
        executable = vim.fn.executable,
        set = vim.keymap.set,
        env = vim.env.HERDR_ENV,
        get_name = vim.api.nvim_buf_get_name,
        get_lines = vim.api.nvim_buf_get_lines,
        getpos = vim.fn.getpos,
        mode = vim.fn.mode,
        getregion = vim.fn.getregion,
    }
    vim.env.HERDR_ENV = '1'
    rawset(vim.fn, 'executable', function() return 1 end)
    rawset(vim.keymap, 'set', function(modes, key, callback)
        for _, mode in ipairs(type(modes) == 'table' and modes or { modes }) do
            mappings[mode .. key] = callback
        end
    end)
    rawset(vim, 'notify', function(message, level)
        notices[#notices + 1] = message
        levels[#levels + 1] = level
    end)
    rawset(vim.api, 'nvim_buf_get_name', function() return options.unnamed and '' or path end)
    rawset(vim.api, 'nvim_buf_get_lines', function()
        contents_read = true
        return { 'buffer contents must never be sent' }
    end)
    rawset(vim.fn, 'getpos', function() return { 0, 1, 1, 0 } end)
    rawset(vim.fn, 'mode', function() return 'v' end)
    rawset(vim.fn, 'getregion', function() return { 'selected text' } end)
    rawset(vim, 'system', function(command, _, callback)
        commands[#commands + 1] = command
        local result
        if command[2] == 'pane' and command[3] == 'neighbor' then
            result = { neighbor = { neighbor_pane_id = options.split and vim.NIL or 'right' } }
        elseif command[3] == 'split' then
            result = { pane = { pane_id = 'new-right' } }
        elseif command[3] == 'process-info' then
            result = { process_info = {
                foreground_processes = { process },
                shell_pid = 42,
                foreground_process_group_id = options.group or 42,
            } }
        elseif command[2] == 'agent' and command[3] == 'get' then
            result = { agent = {
                agent = 'opencode',
                agent_status = options.status or 'idle',
                interactive_ready = not options.not_ready,
                launch_pending = options.pending or false,
            } }
        elseif command[2] == 'agent' and command[3] == 'focus' then
            result = { type = 'ok' }
        else
            result = {}
        end
        vim.schedule(function()
            callback({
                code = (options.fail_send and command[3] == 'send-text'
                    or options.fail_focus and command[3] == 'focus') and 1 or 0,
                stderr = options.fail_focus and 'mock focus failed' or 'mock send failed',
                stdout = options.empty_stdout == command[3] and ''
                    or options.bad_json == command[3] and 'not json'
                    or vim.json.encode({ result = result }),
            })
        end)
    end)
    load_plugin()
    mappings[options.mapping or 'n<leader>af']()
    if options.busy then mappings['n<leader>ao']() end
    vim.wait(1000, function()
        return #notices > (options.busy and 1 or 0)
            or (#commands > 0 and commands[#commands][3] == 'focus')
    end)
    vim.system, vim.notify = original.system, original.notify
    vim.fn.executable, vim.keymap.set = original.executable, original.set
    vim.env.HERDR_ENV = original.env
    vim.api.nvim_buf_get_name = original.get_name
    vim.api.nvim_buf_get_lines = original.get_lines
    vim.fn.getpos, vim.fn.mode, vim.fn.getregion = original.getpos, original.mode, original.getregion

    local actions = {}
    local payload_ok = true
    local recipient = options.split and 'new-right' or 'right'
    local payload = options.mapping == 'x<leader>av'
        and ('Context from file: ' .. path .. ' (lines 1-1)\n\n```\nselected text\n```')
        or '@' .. (options.expected_path or 'example file.lua')
    for _, command in ipairs(commands) do
        actions[#actions + 1] = command[3]
        if command[3] == 'send-text' then
            payload_ok = payload_ok and command[5] == '\27[200~' .. payload .. '\27[201~'
                and #command == 5 and command[4] == recipient
        elseif command[3] == 'focus' then
            payload_ok = payload_ok and table.concat(command, ',')
                == 'herdr,agent,focus,' .. recipient
        end
    end
    local actual = table.concat(actions, ',')
    local wanted = 'neighbor,' .. (options.split and 'split,' or '') .. 'process-info'
        .. (expected ~= '' and ',' .. expected or '')
    if options.unnamed then wanted = '' end
    local ok = actual == wanted and payload_ok and not contents_read
    if options.unnamed then
        ok = ok and #notices == 1
            and notices[1] == 'Save the buffer before sending its filename'
            and levels[1] == vim.log.levels.WARN
    elseif options.refusal then
        ok = ok and notices[#notices]
            and notices[#notices]:find(options.refusal, 1, true) ~= nil
    elseif options.busy then
        ok = ok and #notices == 1 and notices[1]:find('already in progress', 1, true) ~= nil
    else
        ok = ok and #notices == 0
    end
    if not ok then
        failures[#failures + 1] = name .. ': ' .. actual .. '; ' .. table.concat(notices, '; ')
    end
end

check('native argv-only', {
    argv = { 'opencode' }, cmdline = 'opencode', name = 'opencode', pid = 267369,
}, 'get,send-text,focus')
check('idle shell argv-only', { argv = { '/bin/bash' }, pid = 42 }, 'start,send-text,focus')
check('legacy argv0', { argv0 = '/usr/bin/opencode' }, 'get,send-text,focus')
check('name fallback', { name = 'opencode' }, 'get,send-text,focus')
check('bun script', { argv = { '/usr/bin/bun', '/opt/opencode' } }, 'get,send-text,focus')
check('node script', {
    argv0 = '/usr/bin/node', argv = { 'node', '/opt/opencode' },
}, 'get,send-text,focus')
check('occupied', { argv = { '/usr/bin/vim' }, name = 'opencode', pid = 42 }, '', {
    refusal = 'Right pane is occupied or unknown; refusing to send input',
})
check('shell wrong pid', { argv = { 'bash' }, pid = 43 }, '', {
    refusal = 'Right pane is occupied or unknown; refusing to send input',
})
check('shell wrong group', { argv = { '-zsh' }, pid = 42 }, '', {
    group = 43, refusal = 'Right pane is occupied or unknown; refusing to send input',
})
check('unknown cmdline only', { cmdline = 'opencode' }, '', {
    refusal = 'Right pane is occupied or unknown; refusing to send input',
})
check('not ready', { argv0 = 'opencode' }, 'get', {
    not_ready = true, refusal = 'Right OpenCode pane is not ready for input',
})
check('pending', { argv0 = 'opencode' }, 'get', {
    pending = true, refusal = 'Right OpenCode pane is not ready for input',
})
check('working', { argv0 = 'opencode' }, 'get', {
    status = 'working', refusal = 'Right OpenCode pane is not ready for input',
})
check('busy guard', { argv0 = 'opencode' }, 'get,send-text,focus', { busy = true })
check('unnamed buffer', { argv0 = 'opencode' }, '', { unnamed = true })
check('nested project filename', { argv0 = 'opencode' }, 'get,send-text,focus', {
    path = vim.fn.getcwd() .. '/kickstart/init.lua', expected_path = 'kickstart/init.lua',
})
check('nested filename with spaces', { argv0 = 'opencode' }, 'get,send-text,focus', {
    path = vim.fn.getcwd() .. '/nested folder/example file.lua',
    expected_path = 'nested folder/example file.lua',
})
check('outside project filename', { argv0 = 'opencode' }, 'get,send-text,focus', {
    path = '/tmp/opencode/outside.lua', expected_path = '/tmp/opencode/outside.lua',
})
check('similar project prefix filename', { argv0 = 'opencode' }, 'get,send-text,focus', {
    path = vim.fn.getcwd() .. '-other/example.lua',
    expected_path = vim.fn.getcwd() .. '-other/example.lua',
})
check('new shell pane', { argv = { 'bash' }, pid = 42 }, 'start,send-text,focus', { split = true })
check('visual selection', { argv0 = 'opencode' }, 'get,send-text,focus', { mapping = 'x<leader>av' })
check('open only', { argv0 = 'opencode' }, 'get,focus', { mapping = 'n<leader>ao' })
check('open new shell', { argv = { 'bash' }, pid = 42 }, 'start,focus', {
    mapping = 'n<leader>ao', split = true,
})
check('failed send', { argv0 = 'opencode' }, 'get,send-text', {
    fail_send = true, refusal = 'mock send failed',
})
check('empty send acknowledgement focuses recipient once', { argv0 = 'opencode' },
    'get,send-text,focus', { empty_stdout = 'send-text' })
check('non-JSON send acknowledgement focuses recipient once', { argv0 = 'opencode' },
    'get,send-text,focus', { bad_json = 'send-text' })
check('failed focus', { argv0 = 'opencode' }, 'get,send-text,focus', {
    fail_focus = true, refusal = 'mock focus failed',
})
check('focus only needs exit status', { argv0 = 'opencode' }, 'get,send-text,focus', {
    bad_json = 'focus',
})
check('invalid process JSON refuses send', { argv0 = 'opencode' }, '', {
    bad_json = 'process-info', refusal = 'Invalid Herdr JSON response from pane process-info',
})

local picker_labels = {
    'changes: Review Git changes', 'diagnostics: Fix file diagnostics',
    'diagnostics_all: Fix all diagnostics', 'document: Add documentation',
    'explain: Explain context', 'fix: Fix context', 'optimize: Optimize context',
    'review: Review file', 'tests: Write tests', 'quickfix: Use quickfix entries',
}
local prompt_cases = 0

local function check_prompt(action, fragments, options)
    options = options or {}
    prompt_cases = prompt_cases + 1
    local mappings, commands, git_commands, notices, overrides = {}, {}, {}, {}, {}
    local selected, done, changed = nil, false, false
    local diagnostic_calls, quickfix_calls, line_reads, region_reads = 0, 0, 0, 0
    local origin, other = 71, 72
    local cwd = vim.fn.getcwd()
    local path = options.outside and '/tmp/outside.lua' or cwd .. '/src/example file.lua'
    local reference = options.outside and '@/tmp/outside.lua' or '@src/example file.lua'
    local function override(target, key, value)
        overrides[#overrides + 1] = { target, key, rawget(target, key) }
        rawset(target, key, value)
    end
    local function expect(ok, message)
        if not ok then failures[#failures + 1] = action .. ': ' .. message end
    end
    local diagnostic_fixture = {
        { bufnr = origin, namespace = 1, lnum = 2, col = 4, severity = 1,
            source = 'lua_ls', code = 'E1', message = 'first line\nsecond line' },
        { bufnr = origin, namespace = 2, lnum = 4, col = 1, severity = 2,
            source = 'lint', code = 42, message = 'warning' },
        { bufnr = other, namespace = 1, lnum = 6, col = 2, severity = 3,
            message = 'information' },
        { bufnr = other, namespace = 2, lnum = 8, col = 3, severity = 4,
            message = 'hint' },
    }
    override(vim.keymap, 'set', function(modes, key, callback)
        if key ~= '<leader>ap' then return end
        for _, mode in ipairs(type(modes) == 'table' and modes or { modes }) do
            mappings[mode] = callback
        end
    end)
    override(vim.api, 'nvim_get_current_buf', function() return changed and other or origin end)
    override(vim.api, 'nvim_buf_is_valid', function(buf) return buf == origin or buf == other end)
    override(vim.api, 'nvim_buf_get_name', function(buf)
        if buf == 0 then buf = changed and other or origin end
        if buf == origin then return options.unnamed and '' or path end
        return cwd .. '/other.lua'
    end)
    override(vim.api, 'nvim_win_get_cursor', function()
        return changed and { 99, 40 } or { 3, 4 }
    end)
    override(vim.api, 'nvim_buf_get_lines', function(buf, first, last)
        line_reads = line_reads + 1
        expect(buf == origin or (buf == 0 and not changed), 'read changed buffer')
        expect(first == 2 and last == 3, 'read beyond the original cursor line')
        return { 'original cursor line' }
    end)
    override(vim.fn, 'mode', function() return options.visual or 'n' end)
    override(vim.fn, 'getpos', function(mark)
        expect(not changed, 'visual positions captured after picker mutation')
        expect(mark == 'v' or mark == '.', 'unexpected selection mark')
        return mark == 'v' and { origin, 2, 2, 0 } or { origin, 3, 5, 0 }
    end)
    override(vim.fn, 'getregion', function(anchor, cursor, region_options)
        region_reads = region_reads + 1
        expect(not changed, 'selection read after picker mutation')
        expect(anchor[2] == 2 and cursor[2] == 3, 'wrong selection endpoints')
        expect(region_options.type == options.visual, 'visual mode not preserved')
        expect(region_options.exclusive == (vim.o.selection == 'exclusive'),
            'exclusive selection not preserved')
        return { 'selected first', 'selected second' }
    end)
    override(vim.diagnostic, 'get', function(...)
        diagnostic_calls = diagnostic_calls + 1
        if action == 'diagnostics_all' then
            expect(select('#', ...) == 0, 'all diagnostics lookup must be unfiltered')
        else
            expect(select('#', ...) == 1 and (...) == origin,
                'file diagnostics lookup must use captured buffer, no filters')
        end
        if options.empty then return {} end
        if action == 'diagnostics_all' then return diagnostic_fixture end
        -- Multiple namespaces and every severity in the captured file.
        local diagnostics = vim.deepcopy(diagnostic_fixture)
        for _, diagnostic in ipairs(diagnostics) do diagnostic.bufnr = origin end
        return diagnostics
    end)
    override(vim.fn, 'getqflist', function(what)
        quickfix_calls = quickfix_calls + 1
        local entries = options.empty and {} or {
            { bufnr = other, lnum = 8, col = 2, text = 'other file problem', valid = 1 },
            { filename = cwd .. '/third.lua', lnum = 4, col = 6, text = 'third problem', valid = 1 },
            { bufnr = 0, lnum = 0, col = 0, text = 'useful text-only entry', valid = 0 },
        }
        return what and { items = entries } or entries
    end)
    override(vim.fn, 'executable', function() return 1 end)
    override(vim, 'notify', function(message) notices[#notices + 1] = message end)
    override(vim.env, 'HERDR_ENV', '1')
    override(vim.ui, 'select', function(items, _, callback)
        selected = items
        changed = options.delayed or false
        vim.schedule(function()
            local choice
            for _, label in ipairs(picker_labels) do
                if label:match('^([^:]+):') == action then choice = label end
            end
            callback(not options.cancel and choice or nil)
            done = true
        end)
    end)
    override(vim, 'system', function(command, system_options, callback)
        if command[1] == 'git' then
            git_commands[#git_commands + 1] = command
            expect(system_options.cwd == cwd, 'Git cwd not captured')
            local joined = table.concat(command, ' ')
            local diff = vim.tbl_contains(command, 'diff')
            if diff then
                for _, flag in ipairs({ '--no-ext-diff', '--no-textconv', '--no-color' }) do
                    expect(vim.tbl_contains(command, flag), 'unsafe Git diff: missing ' .. flag)
                end
            end
            local cached = vim.tbl_contains(command, '--cached') or vim.tbl_contains(command, '--staged')
            local result = {
                code = options.git_error and 128 or 0,
                stderr = options.git_error and 'fatal: not a git repository' or '',
                stdout = diff and (options.empty and '' or cached and 'STAGED_DIFF' or 'UNSTAGED_DIFF')
                    or joined:find('rev%-parse') and 'true\n' or '',
            }
            -- Empty cached diffs in an unborn repo are successful, not an error.
            if options.unborn and cached then result.stdout = '' end
            if callback then vim.schedule(function() callback(result) end) end
            return { wait = function() return result end }
        end
        expect(command[1] == 'herdr', 'unexpected external command')
        commands[#commands + 1] = command
        local result = command[3] == 'neighbor' and { neighbor = { neighbor_pane_id = 'right' } }
            or command[3] == 'process-info' and { process_info = {
                foreground_processes = { { argv = { 'opencode' } } },
                shell_pid = 42, foreground_process_group_id = 42,
            } } or command[3] == 'get' and { agent = {
                agent = 'opencode', agent_status = 'idle', interactive_ready = true,
            } } or {}
        vim.schedule(function()
            callback({ code = 0, stdout = command[3] == 'send-text' and ''
                or vim.json.encode({ result = result }) })
        end)
    end)
    load_plugin()
    expect(type(mappings.n) == 'function' and type(mappings.x) == 'function',
        'normal and visual ap mappings must both exist')
    local callback = mappings[options.visual and 'x' or 'n']
    if callback then callback() else done = true end
    vim.wait(1000, function()
        return done and (#notices > 0 or options.cancel
            or (#commands > 0 and commands[#commands][3] == 'focus'))
    end)
    local sent, sends, focuses = nil, 0, 0
    for _, command in ipairs(commands) do
        if command[3] == 'send-text' then
            sends = sends + 1
            sent = command[5]
            expect(command[4] == 'right' and #command == 5, 'wrong send recipient/auto-submit')
        elseif command[3] == 'focus' then
            focuses = focuses + 1
            expect(table.concat(command, ',') == 'herdr,agent,focus,right', 'wrong focus target')
        end
    end
    expect(selected and table.concat(selected, '|') == table.concat(picker_labels, '|'),
        'picker labels/order mismatch')
    if fragments then
        expect(sends == 1 and focuses == 1, 'must send once and focus once')
        local payload = sent or ''
        expect(payload:sub(1, 6) == '\27[200~' and payload:sub(-6) == '\27[201~',
            'missing bracketed paste boundaries')
        for _, fragment in ipairs(fragments) do
            fragment = fragment:gsub('REFERENCE', function() return reference end)
            expect(payload:find(fragment, 1, true) ~= nil, 'missing payload fragment: ' .. fragment)
        end
        expect(not payload:match('{[%w_]+}'), 'unresolved template token')
        expect(not payload:find('99:41', 1, true), 'used changed cursor')
        if action == 'quickfix' then
            expect(not payload:find(cwd .. '/', 1, true), 'quickfix paths not cwd-relative')
        end
    else
        expect(#commands == 0, 'unexpected Herdr call for empty/cancelled/unnamed context')
    end
    if options.cancel then
        expect(diagnostic_calls == 0 and quickfix_calls == 0 and #git_commands == 0,
            'cancel performed heavy context lookup')
    elseif action == 'diagnostics_all' or (action == 'diagnostics' and not options.unnamed) then
        expect(diagnostic_calls == 1, 'missing diagnostic lookup')
    elseif action == 'quickfix' then
        expect(quickfix_calls == 1, 'missing quickfix lookup')
    end
    expect(line_reads == 0 or (not options.visual and line_reads == 1),
        'unnecessary file contents read')
    expect(region_reads == 0 or (options.visual and region_reads == 1),
        'unnecessary selection read')
    for index = #overrides, 1, -1 do
        local item = overrides[index]
        rawset(item[1], item[2], item[3])
    end
end

check_prompt('changes', { 'Can you review my changes?', 'STAGED_DIFF', 'UNSTAGED_DIFF' },
    { unnamed = true, delayed = true })
check_prompt('changes', { 'Can you review my changes?', 'UNSTAGED_DIFF' }, { unborn = true })
check_prompt('changes', nil, { empty = true })
check_prompt('changes', nil, { git_error = true })
local diagnostic_fragments = {
    'Can you help me fix the diagnostics in REFERENCE?', '3:5', 'ERROR', 'lua_ls', 'E1',
    'first line\nsecond line', '5:2', 'WARN', 'lint', '42', 'INFO', 'HINT',
}
check_prompt('diagnostics', diagnostic_fragments, { delayed = true })
check_prompt('diagnostics', nil, { empty = true })
check_prompt('diagnostics_all', {
    'Can you help me fix these diagnostics?', '@other.lua', '7:3', '9:4',
    'ERROR', 'WARN', 'INFO', 'HINT', 'first line\nsecond line',
}, { unnamed = true, delayed = true })
check_prompt('diagnostics_all', nil, { empty = true })
check_prompt('document', { 'Add documentation to', 'REFERENCE', '3:5' }, { delayed = true })
check_prompt('explain', { 'Explain', 'REFERENCE', '3:5', 'original cursor line' }, { delayed = true })
check_prompt('fix', { 'Can you fix', 'REFERENCE', 'original cursor line', '?' })
check_prompt('optimize', { 'How can', 'REFERENCE', 'original cursor line', 'be optimized?' })
check_prompt('review', { 'Can you review REFERENCE for any issues or improvements?' })
check_prompt('review', { 'Can you review REFERENCE for any issues or improvements?' }, { outside = true })
check_prompt('tests', { 'Can you write tests for', 'REFERENCE', 'original cursor line', '?' })
check_prompt('quickfix', {
    'other.lua:8:2', 'other file problem', 'third.lua:4:6', 'third problem',
    'useful text-only entry',
}, { unnamed = true })
check_prompt('quickfix', nil, { empty = true })
for _, action in ipairs({ 'diagnostics', 'document', 'explain', 'fix', 'optimize', 'review', 'tests' }) do
    check_prompt(action, nil, { unnamed = true })
end
for _, action in ipairs({ 'changes', 'diagnostics', 'diagnostics_all', 'quickfix', 'explain' }) do
    check_prompt(action, nil, { cancel = true })
end
local original_selection = vim.o.selection
for _, mode in ipairs({ 'v', 'V', '\22' }) do
    vim.o.selection = 'exclusive'
    check_prompt('explain', {
        'Explain', 'REFERENCE', 'selected first\nselected second', '2:',
    }, { visual = mode, delayed = true })
end
vim.o.selection = original_selection
if #failures > 0 then error(table.concat(failures, '\n')) end
print('PASS: 29 transport/safety cases and ' .. prompt_cases .. ' expanded-picker cases')
