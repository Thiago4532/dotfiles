syntax match MyCOperator "\^\|?\|:\|+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
syntax match MyCPunctDelimiter ";\|,"
syntax keyword Normal stdin stdout stderr

hi link MyCOperator Operator
hi link MyCPunctDelimiter TSPunctDelimiter
