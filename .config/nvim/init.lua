-- dofile(vim.fn.expand('~/.config/nvim/lua/profiler.lua'))
require 'impatient'
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

-- vimwiki
g.vimwiki_list = {{path = '~/Documents/vimwiki', path_html = '~/Documents/HTML'}}

-- disable providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

cmd[[
noremap , "+
nnoremap ,, ,
]]
g.mapleader = ','

require 'config.editor'
require 'config.keybindings'

cmd[[
source ~/.config/nvim/vimscript/ui.vim
source ~/.config/nvim/vimscript/autocmd.vim
]]
