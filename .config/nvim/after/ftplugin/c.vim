nnoremap <buffer> <silent> <leader>ch diW:lua require'snippets'.call('c/header', string.gsub(vim.fn.getreg('"'), '[\n\r]', ' '))<CR>
