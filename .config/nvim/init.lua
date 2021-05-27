dofile(vim.fn.expand('~/.config/nvim/lua/profiler.lua'))
local g = vim.g
local cmd = vim.cmd

g.polyglot_disabled = {'sensible'}

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

g.mapleader = ','
g.AutoPairsOpenBalanceBlacklist = {'{'}

-- vim-plug: Source all plugins
cmd'source ~/.config/nvim/vimscript/plugins.vim'
cmd'source ~/.config/nvim/vimscript/util.vim'

require 'self.lsp'
require 'self.statusline'
require 'self.autocmd'
require 'self.editor'
require 'self.keybindings'
require 'self.ui'
