syntax match MyCOperator "\^\|\[\|\]\|?\|:\|+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
syntax match MyCPunctDelimiter ";\|,"
syntax keyword Normal stdin stdout stderr

hi link MyCOperator Operator
hi link MyCPunctDelimiter TSPunctDelimiter

hi link cStructure cppStructure

syn keyword	Statement	_Static_assert static_assert

" hi link @keyword.import.c Include
" hi link @keyword.import.cpp Include
" hi link @keyword.import.cuda Include
