local put_snippet = require'snippets'.put_snippet

local header =
[[#ifndef $1
#define $1

$C

#endif]]

return {
    header = header
}
