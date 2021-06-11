set omnifunc=v:lua.vim.lsp.omnifunc

" Competitve Programming

nnoremap <silent> <leader>rr :t.<CR>^"_ct cin >><Esc>:s/,/ >>/ge<CR>:s/; .\{-\} / >> /ge<CR>:noh<CR>
nnoremap <silent> <leader>cll :lua require'self.util'.cf_int_ll()<CR>
