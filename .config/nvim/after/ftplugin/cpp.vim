" Competitve Programming

nnoremap <buffer> <silent> cpp ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>G"_dd2k$
nnoremap <buffer> <silent> ,ct i<TAB>int t;<CR>cin >> t;<CR>for (int i = 1; i <= t; i++) {<CR>runAndPrint(solve);<CR>}<ESC>6kO<ESC>oauto solve() {<CR><CR>}<ESC>ki<TAB><ESC>
nnoremap <buffer> <silent> <leader>cll :lua util.cp_int2ll()<CR>

" Go to bits/stdc++.h line
nnoremap <buffer> <silent> gb /bits\/stdc<CR>:noh<CR>0zt
