if !exists("g:terminal_background") && !empty($TERM_BG_COLOR)
    let g:terminal_background=$TERM_BG_COLOR
endif

if exists("g:terminal_background")
    autocmd VimEnter,VimResume * call dtbg#SetTerminalColor(g:vim_background)
    autocmd VimLeave,VimSuspend * call dtbg#SetTerminalColor(g:terminal_background)
endif
