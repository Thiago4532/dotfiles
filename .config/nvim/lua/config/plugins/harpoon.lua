local vim = vim
local ui = require'harpoon.ui'

local function map(lhs, rhs)
    return vim.keymap.set('n', lhs, rhs, { silent = true })
end

map('<space>a', function()
    require'harpoon.mark'.add_file()
end)

map('<space>q', function() ui.toggle_quick_menu() end)
map('<space>1', function() ui.nav_file(1) end)
map('<space>2', function() ui.nav_file(2) end)
map('<space>3', function() ui.nav_file(3) end)
map('<space>4', function() ui.nav_file(4) end)
map('<space>5', function() ui.nav_file(5) end)
map('<space>6', function() ui.nav_file(6) end)
map('<space>7', function() ui.nav_file(7) end)
map('<space>8', function() ui.nav_file(8) end)
map('<space>9', function() ui.nav_file(9) end)
