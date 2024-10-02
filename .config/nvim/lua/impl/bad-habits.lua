local vim = vim
local api = vim.api

local function err_message(...)
    local message = table.concat(vim.iter({ ... }):flatten():totable())
    -- api.nvim_echo({{ message, "ErrorMsg" }}, false, {})
    api.nvim_err_writeln(message)
end

local function map(mode, lhs, rhs, expr)
    local opts = { silent = true }
    if expr then
        opts.expr = true
    end

    return vim.keymap.set(mode, lhs, rhs, opts)
end

-- Use cpy/%y+ instead of gg,yG

local function try_copy()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    if r == 1 then
        err_message 'AVISO: Usa o cpy porra!'
    else
        err_message 'AVISO: Usa o cpy porra! Ia dando merda dessa vez'
    end
end

map('n', ',yG', try_copy)

local blocklist = {'h', 'j', 'k', 'l'}
local safe_amount = 2

local blocking = {}
for _, key in ipairs(blocklist) do
    blocking[key] = false
end
tm_blocking = blocking

local current_key = nil
local current_count = 0

local ns = vim.api.nvim_create_namespace('tm-bad-habits')
vim.on_key(function(key, typed)
    if not key then
        return
    end

    if blocking[key] == nil then
        if current_key then
            blocking[current_key] = false
            current_key = nil
        end
        return
    end

    if current_key == key then
        current_count = current_count + 1
    else
        if current_key then
            blocking[current_key] = false
        end
        current_key = key
        current_count = 1
    end

    if current_count >= safe_amount then
        blocking[key] = true
    end
end, ns)

