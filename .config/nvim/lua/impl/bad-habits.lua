local vim = vim
local api = vim.api
local uv = vim.uv

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
local timeout = 1000
local bark_tries = 3

local blocking = {}
local num_tries = {}
for _, key in ipairs(blocklist) do
    blocking[key] = 0
    num_tries[key] = 0
end

local function check(key)
    local now = uv.now()
    if now - blocking[key] < timeout then
        local message = 'You pressed ' .. key .. ' too soon!'
        api.nvim_echo({{ message, 'ErrorMsg' }}, false, {})

        num_tries[key] = num_tries[key] + 1
        if num_tries[key] == bark_tries then
            require'util'.bark()
        end
        return ''
    end

    blocking[key] = now
    num_tries[key] = 0
    return key
end

-- map({'n', 'x'}, 'j', function()
--     if vim.v.count > 1 then
--         return "m'" .. vim.v.count .. 'j'
--     end
--     return check 'j'
-- end, true)

-- map({'n', 'x'}, 'k', function()
--     if vim.v.count > 1 then
--         return "m'" .. vim.v.count .. 'k'
--     end
--     return check 'k'
-- end, true)

-- map({'n', 'x'}, 'h', function()
--     return check 'h'
-- end, true)

-- map({'n', 'x'}, 'l', function()
--     return check 'l'
-- end, true)
