vim.loader.enable()

local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

-- disable providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0 g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.zig_fmt_autosave = 0
g.mapleader = ','
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

require 'plugins'
require 'buf-config'.setup()

-- post-plugin configuration

util = require'util'

require 'config.editor'
require 'config.keybindings'

cmd[[
runtime vimscript/ui.vim
runtime vimscript/autocmd.vim
runtime vimscript/commands.vim
]]

function printi(...)
    local tbl = vim.tbl_map(vim.inspect, {...})
    local n = select('#', ...)

    print(unpack(tbl, 1, n))
end
