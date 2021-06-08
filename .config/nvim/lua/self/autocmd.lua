local cmd = vim.cmd

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

-- autocmd: Neovim's terminal
cmd([[
augroup neovim_terminal
    autocmd!
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
augroup END
]])
