local hop = require'hop'

hop.setup {}

-- Keymapping
local map = vim.keymap.set
-- local directions = require('hop.hint').HintDirection

map('', '<space>w', function()
    hop.hint_words()
end, {remap=true})

map('', '<space>f', function()
    hop.hint_char1({ current_line_only = true })
end, {remap=true})

map('', '<space>t', function()
    hop.hint_char1({ current_line_only = true, hint_offset = -1 })
end, {remap=true})
