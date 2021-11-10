local vim = vim
local api = vim.api
local uv = vim.loop

local dirpath = debug.getinfo(1, 'S').source:match("@(.*[/\\])")

local function put_snippet(snippet, args)
    assert(snippet, "invalid snippet!")
    args = args or {}

    local old_indentexpr = api.nvim_buf_get_option(0, "indentexpr")
    api.nvim_buf_set_option(0, "indentexpr", "")

    -- Insert newline
    snippet = "\n" .. snippet

    match = snippet:match("\n([\t ]+)")

    if match then
        local level = 0
        local shiftnext = "\x14"
        local shiftprev = "\x04"

        snippet = snippet:gsub("\n([\t ]*)", function(c)
            local c, count = c:gsub(match, "")

            ind = ""
            if count > level then ind = shiftnext:rep(count - level) end
            if count < level then ind = shiftprev:rep(level - count) end

            level = count
            return string.format("\n%s%s", ind, c)
        end)
    end

    local has_cursor = false

    snippet = snippet:gsub("\n", "\r")
    snippet = snippet:gsub("([^%$])%$([A-Za-z0-9]+)", function(prefix, c)
        if c == "C" and not has_cursor then
            has_cursor = true
            return prefix .. "c\x1bm'a"
        end

        local num = tonumber(c)
        if num and num > 0 then
            return prefix .. (args[num] or "")
        end

        return prefix
    end)

    snippet = snippet:gsub("([^%$])%${(.-)}", function(prefix, func)
        func = func:gsub("[^%$]%$%(", "{")
        func = func:gsub("[^%$]%$%)", "}")
        func = func:gsub("%$%$%)", "$")

        if func then
            local f, err = loadstring("return " .. func)
            assert(f, err)

            return prefix .. f()
        end
    end)
    snippet = snippet:gsub("%$%$", "$")

    if has_cursor then
        snippet = snippet .. "\x1b`'\"_x"
    end

    -- Remove newline
    snippet = snippet:sub(2)
    
    vim.cmd("normal! i" .. snippet)
    api.nvim_buf_set_option(0, "indentexpr", old_indentexpr)
end

local function readFileSync(path)
    local fd = assert(uv.fs_open(path, "r", 438))
    local stat = assert(uv.fs_fstat(fd))
    local data = assert(uv.fs_read(fd, stat.size, 0))
    assert(uv.fs_close(fd))
    return data
end

local function call(snippet, ...)
    local data = readFileSync(string.format('%s/%s.snip', dirpath, snippet))
    if data:sub(-1, -1) == '\n' then
        data = data:sub(1, -2)
    end

    args = {...}
    return put_snippet(data, args)
end

return { put_snippet = put_snippet, call = call }
