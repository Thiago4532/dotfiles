--dofile(vim.fn.expand('~/.config/nvim/lua/profiler.lua'))
local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

local notes = '~/Notes'

g.polyglot_disabled = {'sensible'}

g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

cmd'noremap , <Nop>'
g.mapleader = ','
g.AutoPairsOpenBalanceBlacklist = {'{'}

-- vim-plug: Source all plugins
cmd'source ~/.config/nvim/vimscript/plugins.vim'

require 'self.lsp'
require 'self.statusline'
require 'self.editor'
require 'self.keybindings'

cmd[[
source ~/.config/nvim/vimscript/ui.vim
source ~/.config/nvim/vimscript/autocmd.vim
]]

local nregex = '^' .. fn.expand(notes)
local cwd = fn.getcwd()

if cwd:find(nregex) then
    require'neuron'.setup {
        neuron_dir = notes, -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
    }
end

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'c', 'cpp', 'bash'}
    },
    --[[ playground = {
        enable = true,
    }, ]]
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})
