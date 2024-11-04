local vim = vim

local api = vim.api
local uv = vim.uv
local bo = vim.bo

local M = {}

function M.err_message(...)
    local message = table.concat(vim.iter({ ... }):flatten():totable())
    if vim.in_fast_event() then
        vim.schedule(function()
            api.nvim_err_writeln(message)
            api.nvim_command('redraw')
        end)
    else
        api.nvim_err_writeln(message)
        api.nvim_command('redraw')
    end
end

M.parse_c_header_name = function(name)
    local guard_name = require'header-guard'.guard_name()
    if guard_name then
        return guard_name
    end

    return name
end

M.set_indent = function(spaces, use_tab)
    use_tab = use_tab or false

    bo.softtabstop = spaces
    bo.shiftwidth = spaces

    if use_tab then
        bo.tabstop = spaces
        bo.expandtab = false
    else
        bo.tabstop = 8
        bo.expandtab = true
    end
end

M.write_indent_modeline = function()
    local comment = bo.commentstring
    if comment:len() == 0 then
        api.nvim_err_writeln("Failed to write_indent_modeline: commentstring is empty!")
        return
    end

    -- Trim whitespaces
    comment = comment:gsub(" *(%%s) *", "%1")

    local expandtab = bo.expandtab and "et" or "noet"
    local modeline = string.format(" vim: %s ts=%d sts=%d sw=%d",
                                    expandtab,
                                    bo.tabstop,
                                    bo.softtabstop,
                                    bo.shiftwidth)
    api.nvim_buf_set_lines(0, -1, -1, true, {comment:format(modeline)})
end


local function notify_send(title, msg, id)
    local args = {'-i', 'nvim', title, msg}
    if id ~= nil then
        args[#args + 1] = '-r'
        args[#args + 1] = id
    end

    M.spawn_bg('notify-send', args)
end
M.notify_send = notify_send

local notification_ids = setmetatable({}, {
    __index = function(self, title)
        local id = math.floor(math.random() * 1e6)

        self[title] = id
        return id
    end
})

function M.notifyi(opts)
    local title, id
    if type(opts) == 'table' then
        title = opts[1]
        id = opts[2] or notification_ids[title]
    elseif type(opts) == 'string' then
        title = opts
        id = nil
    else
        error('opts: expected table or string')
    end

    return function(...)
        local msg = {...}
        for i=1,select('#', ...) do
            if msg == nil then
                msg[i] = 'nil'
            else
                msg[i] = tostring(msg[i])
            end
        end
        msg = table.concat(msg, ' ')

        return notify_send(title, msg, id)
    end 
end

M.notify = M.notifyi 'Neovim'

local clock = nil
M.clock_reset = function()
    clock = uv.hrtime()
end

M.clock_print = function()
    if clock then
        local time = (uv.hrtime() - clock) / 1e6
        print("Clock:", time)
    end
end

M.clock_notify = function(unique)
    if clock then
        local time = (uv.hrtime() - clock) / 1e6
        if unique then
            M.notifyi 'Clock' (time .. 'ms')
        else
            M.notifyi {'Clock', 674532} (time .. 'ms')
        end
    end
end
M.clock_dunst = M.clock_notify -- Compatibility

M.center_cursor = function()
    local cursor = api.nvim_win_get_cursor(0)
    vim.cmd(string.format('normal! %dzt', cursor[1] - 10))
    api.nvim_win_set_cursor(0, cursor)
end

M.is_executable = function(...)
    for i=1,select('#', ...) do
        local arg = select(i, ...)
        if vim.fn.executable(arg) == 0 then
            return false
        end
    end
    return true
end

M.sanitize_ascii = function(s)
    local ss = s:gsub('[^\x20-\x7F]', function(c)
        local byte = c:byte(1)
        return string.format('\\x%02x', byte);
    end)
    return ss
end

-- Spawn and detach
M.spawn_bg = function(cmd, opts)
    opts = opts or {}
    local args = {}
    for k,v in ipairs(opts) do
        args[k] = v
    end

    local handle
    handle = uv.spawn(cmd, {
        args = args,
        detached = false,
    }, function(code, signal)
        if code ~= 0 or signal ~= 0 then
            if not opts.silent then
                local err = code == 0 and 'signal='..signal or 'code='..code
                M.err_message(string.format('spawn_bg: failed to spawn %s: %s', cmd, err))
            end
        end
    end)
    if not handle then
        if not opts.silent then
            M.err_message('spawn_bg: failed to spawn', cmd)
        end
    end
    handle:close()
    handle:unref()
end

M.bark = function()
    if not M.is_executable'bark' then
        return
    end

    M.spawn_bg('bark', {silent = true})
end

return M
