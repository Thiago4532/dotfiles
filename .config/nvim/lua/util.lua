local vim = vim

local api = vim.api
local uv = vim.loop
local bo = vim.bo

-- Helper functions
local function pattern_size(str, pattern)
    i, j = str:find(pattern)
    if i == nil then
        return nil
    end
    return j - i + 1
end

-- Exported functions
local function cf_int_ll()
    api.nvim_buf_set_lines(0, 1, 1, true, {'#define int ll'})
    local lines = api.nvim_buf_get_lines(0, 0, -1, true);

    api.nvim_command('normal! \x05')
    for i = 1,#lines do
        if lines[i]:find('int main()') then
            local l = lines[i]:gsub('int', 'int32_t')
            api.nvim_buf_set_lines(0, i - 1, i, true, {l}) 
            break
        end
    end
end

local function set_indent(spaces, use_tab)
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

local function write_indent_modeline()
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

local function dunst_notify(title, msg, id)
    local args = {'-i', 'nvim', title, msg}
    if id ~= nil then
        args[#args + 1] = '-r'
        args[#args + 1] = id
    end

    return uv.spawn('dunstify', {
        args = args,
        detach = true,
    })
end

local clock = nil
local function clock_reset()
    clock = uv.hrtime()
end

local function clock_print()
    if clock then
        local time = (uv.hrtime() - clock) / 1e6
        print("Clock:", time)
    end
end

local function clock_dunst()
    if clock then
        local time = (uv.hrtime() - clock) / 1e6
        dunst_notify('Clock', time, '674532')
    end
end

return {
    cf_int_ll = cf_int_ll,
    set_indent = set_indent,
    write_indent_modeline = write_indent_modeline,
    dunst_notify = dunst_notify,
    clock_reset = clock_reset,
    clock_print = clock_print,
    clock_dunst = clock_dunst,
}
