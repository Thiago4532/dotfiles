function util#SignatureHelp()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
            \ . "> trans<" . synIDattr(synID(line("."),col("."),0),"name")
            \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
            \ . ">"
    return ""
endfunction
