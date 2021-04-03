function dtbg#SetTerminalColor(color)
    let color_str = "\033]11;" . a:color . "\007"
    call writefile([color_str], "/dev/stdout", "b")
endfunction
