local api = vim.api

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
    end
}
