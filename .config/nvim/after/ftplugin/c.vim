set omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <buffer> <silent> <leader>ch diW:lua require'snippets'.call('c', 'header', vim.fn.getreg('"'))<CR>
