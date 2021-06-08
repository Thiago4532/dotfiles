dofile(vim.fn.expand('~/.config/nvim/lua/profiler.lua'))
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

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

-- if cwd == fn.expand('~/Notes') then
require'neuron'.setup {
    neuron_dir = "~/Notes", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
}
-- end
