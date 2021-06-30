function util#PrintHighlightGroup()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
            \ . "> trans<" . synIDattr(synID(line("."),col("."),0),"name")
            \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
            \ . ">"
endfunction

function util#PasteString(str)
    let tmp = @p

    let @p = a:str
    normal! "pp
    let @p = tmp
endfunction
