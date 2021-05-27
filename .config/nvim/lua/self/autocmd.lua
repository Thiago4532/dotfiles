local cmd = vim.cmd

-- autocmd: Markdown-only configurations
cmd([[ 
autocmd FileType markdown.mdx nnoremap <silent> <leader>cj :set filetype=javascript<CR>
autocmd FileType markdown.mdx nnoremap <silent> <leader>cm :set filetype=markdown.mdx<CR>
]])

-- autocmd: Toggle 'relativenumber' when using INSERT mode
cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])

-- autocmd: Window's title
cmd'autocmd VimEnter * set title'
