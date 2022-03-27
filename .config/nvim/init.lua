require 'impatient'
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
-- disable providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

cmd[[
noremap , "+
noremap <Space> <Nop>
]]
g.mapleader = ','

util = require'util'

require 'config.editor'
require 'config.keybindings'

cmd[[
runtime vimscript/ui.vim
runtime vimscript/autocmd.vim
 ]]

function printi(...)
    local tbl = vim.tbl_map(vim.inspect, {...})
    local n = select('#', ...)

    print(unpack(tbl, 1, n))
end
