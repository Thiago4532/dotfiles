local vim = vim

local api = vim.api
local uv = vim.loop
local fn = vim.fn

local regdir = '~/Documents/registers'

function save_register(name, register) -- default 'q'
    assert(name:find('^[a-z|A-Z|0-9|_]+$'), name .. ' is not a valid name!')
    assert(string.len(register) == 1, 'invalid register!')

    local filepath = fn.expand(regdir .. '/' .. name)
    local data = fn.getreg(register or 'q')

    uv.fs_open(filepath, 'w', 384, function(err, fd)
        assert(not err, err)
        uv.fs_write(fd, data, nil, function(err, ...)
            assert(not err, err)
            uv.fs_close(fd, function(err, ...)
                assert(not err, err)
            end)
        end)
    end)
end

return {
    cf_int_ll = function()
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
    end,
    save_register = save_register
}
