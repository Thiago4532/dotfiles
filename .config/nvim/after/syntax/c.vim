syntax match MyCOperator "\^\|?\|:\|+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
syntax match MyCPunctDelimiter ";\|,"
syntax keyword Normal stdin stdout stderr

hi link MyCOperator Operator
hi link MyCPunctDelimiter TSPunctDelimiter

hi link cStructure cppStructure
" hi link @lsp.type.class.c Type
