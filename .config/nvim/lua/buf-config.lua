local vim = vim
local uv = vim.loop

local M = {}

local is_windows = uv.os_uname().version:match 'Windows'

local function is_file(filename)
    local stat = uv.fs_stat(filename)
    return stat and stat.type == 'file'
end

local function perror(...)
    vim.api.nvim_err_writeln(table.concat(vim.tbl_flatten({ ... })))
    -- api.nvim_command('redraw')
end


local function match_config(path)
    path = path or vim.api.nvim_buf_get_name(0)
    local is_windows = uv.os_uname().version:match 'Windows'

    -- TODO: is this correct? i've to test it on Windows
    local path_sep_match = is_windows and '[\\/]' or '/'
    local path_sep = is_windows and '\\' or '/'

    local data = vim.fn.stdpath("data") .. path_sep .. 'buf-config' .. path_sep

    path = path:gsub('%%', '%%%%')
    path = path:gsub(path_sep_match, '%%')
    path = path .. '%'

    local configs = {}

    local i = path:find('%%')
    while i ~= nil do
        if path:sub(i+1, i+1) == '%' then
            i = i + 1 -- a valid '%'
        else
            local cfg = data .. path:sub(1, i) .. '.lua'
            if is_file(cfg) then
                configs[#configs + 1] = cfg
            end
        end
        i = path:find('%%', i + 1)
    end
    return configs
end
M.match_config = match_config

M.load = function()
    local configs = match_config()
    for _, file in ipairs(configs) do
        local f, e = loadfile(file)
        if f then
            f()
        else
            perror('buf-config: ', e)
        end
    end
end

M.setup = function()
    vim.cmd [[autocmd BufNewFile,BufRead * lua require'buf-config'.load() ]]
end

return M
