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
g.AutoPairsOpenBalanceBlacklist = {'{'}

-- vim-plug: Source all plugins
cmd'source ~/.config/nvim/vimscript/plugins.vim'

require 'self.lsp'
require 'self.editor'
require 'self.keybindings'

cmd[[
source ~/.config/nvim/vimscript/ui.vim
source ~/.config/nvim/vimscript/autocmd.vim
]]

require'lualine'.setup {
    options = {
        theme = 'gruvbox_material'
    },
    sections = {
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                sections = {'error', 'warn'},
                color_error = '#ea6962',
                color_warn = '#d8a657'
            },
            'encoding',
            'fileformat',
            'filetype'
        },
    },
    extensions = {'nvim-tree'}
}

require'bufferline'.setup{}

require'telescope'.setup{
    defaults = {
        file_ignore_patterns = {'build/.*', 'compile_commands.json'},
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["<c-d>"] = "delete_buffer", ["<c-c>"] = "close" }
            },
            initial_mode = "normal"
        }
    }
}

require'nvim-tree'.setup {}

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'c', 'cpp', 'bash', 'haskell'}
    },
    --[[ playground = {
        enable = true,
    }, ]]
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

