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

    api.nvim_command('normal! ')
    for i = 1,#lines do
        if lines[i]:find('int main()') then
            local l = lines[i]:gsub('int', 'int32_t')
            api.nvim_buf_set_lines(0, i - 1, i, true, {l}) 
            break
        end
    end
end

local function detect_indent()
    -- Reading at most 100 lines
    local lines = api.nvim_buf_get_lines(0, 0, 100, false)

    local use_tab = false
    local spaces = nil

    for i, line in pairs(lines) do
        if not use_tab and line:find('^\t') then
            use_tab = true
        else
            len = pattern_size(line, '^ +')
            if len then
                if not spaces or len < spaces then
                    spaces = len
                end
            end
        end
    end

    if spaces then
        bo.expandtab = true
        bo.tabstop = 8
        bo.softtabstop = spaces
        bo.shiftwidth = spaces
        if use_tab then
            print("Mixed indentation was detected! Using", spaces, "spaces to indent.")
        else
            print("Space indentation was detected! Using", spaces, "spaces to indent.")
        end
    elseif use_tab then
        print ("TAB indentation was detected! Using tab size of", bo.shiftwidth, "characters.")
    else
        print("No indentation was detected!")
    end
end

local function write_indent_modeline(detect)
    local comment = bo.commentstring
    if comment:len() == 0 then
        api.nvim_err_writeln("Failed to write_indent_modeline: commentstring is empty!")
        return
    end

    -- Trim whitespaces
    comment = comment:gsub(" *(%%s) *", "%1")

    if detect then
        detect_indent()
    end

    local expandtab = bo.expandtab and "et" or "noet"
    local modeline = string.format(" vim: %s ts=%d sts=%d sw=%d",
                                    expandtab,
                                    bo.tabstop,
                                    bo.softtabstop,
                                    bo.shiftwidth)
    api.nvim_buf_set_lines(0, -1, -1, true, {comment:format(modeline)})
end

return {
    cf_int_ll = cf_int_ll,
    detect_indent = detect_indent,
    write_indent_modeline = write_indent_modeline
}