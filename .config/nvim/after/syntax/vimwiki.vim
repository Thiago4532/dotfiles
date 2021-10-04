" Markdown
if vimwiki#vars#get_wikilocal("syntax") == "markdown"
    syn match mkInlineMathChar "\s*\$\$\s*" contained conceal
    syn region mkInlineMath start="\$\$" end="\$\$" contains=mkInlineMathChar,@texMathZoneGroup oneline

    hi def link mkInlineMath textSnipTEX
    hi def link mkInlineMathChar VimwikiMath
endif
