local api = vim.api

local map_opts = { silent = true }
local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, map_opts)
end

-- Competitve Programming

local cp_int2ll = function()
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

map('n', 'cpp', [[ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>G"_dd2k$]])
map('n', 'cptl', require'cptl'.load)
map('n', ',ct', [[i<TAB>int t;<CR>cin >> t;<CR>for (int i = 1; i <= t; i++) {<CR>tdeb_test_begin(i);<CR>runAndPrint(mainT, i);<CR>tdeb_test_end(i);<CR>}<ESC>8kO<ESC>oauto mainT(int nT) {<CR><CR>}<ESC>ki<TAB><ESC>]])
map('n', '<leader>cll', cp_int2ll)

-- " Go to bits/stdc++.h line
-- nnoremap <buffer> <silent> gb /bits\/stdc<CR>:noh<CR>0zt
