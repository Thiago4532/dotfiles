augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

autocmd VimEnter * set title

autocmd Filetype markdown,vimwiki let b:autopairs_enabled = 0

augroup neovim_terminal
    autocmd!
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
augroup END

