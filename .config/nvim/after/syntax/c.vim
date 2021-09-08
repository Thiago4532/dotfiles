syntax match MyCOperator "\^\|?\|:\|+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|\.\|/\(/\|*\)\@!"
syntax match MyCPunctDelimiter ";\|,"

hi link MyCOperator Operator
hi link MyCPunctDelimiter Grey
