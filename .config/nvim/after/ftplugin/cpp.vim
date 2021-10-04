" Competitve Programming

nnoremap <buffer> <silent> cpp ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>17zt23gg
nnoremap <buffer> <silent> <leader>rr :t.<CR>^"_ct cin >><Esc>:s/,/ >>/ge<CR>:s/; .\{-\} / >> /ge<CR>:noh<CR>
nnoremap <buffer> <silent> <leader>cll :lua require'self.util'.cf_int_ll()<CR>
