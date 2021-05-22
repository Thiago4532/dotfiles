local api = vim.api
local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

-- plugin: auto-pairs
vim.g.AutoPairsOpenBalanceBlacklist = {'{'}

-- plugin: vim-airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_highlighting_cache = 1
vim.g.airline_skip_empty_sections = 1
vim.g['airline#extensions#tabline#enabled'] = 1

vim.g['airline#extensions#default#layout'] = {{'a', 'b', 'c'}, {'x', 'z', 'warning', 'error'}}
vim.g['airline#extensions#whitespace#enabled'] = 0

-- plugin: coc-nvim
vim.g.coc_global_extensions = {'coc-json', 'coc-rust-analyzer'}

-- plugin: NERDTree
vim.g.NERDTreeWinSize=28 -- Default NERDTree window's size
vim.g.NERDTreeMinimalUI = 1 -- Remove bookmarks and help text from NERDTree

vim.g.NERDTreeFileExtensionHighlightFullName = 1
vim.g.NERDTreeExactMatchHighlightFullName = 1
vim.g.NERDTreePatternMatchHighlightFullName = 1

-- vim-plug: Source all plugins
vim.cmd('source ~/.config/nvim/vimscript/plugins.vim')

-- lsp: ccls setup
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "build";
        index = {
            threads = 0;
        };
        highlight = {
            lsRanges = true;
        }
    }
}

-- autocmd: Markdown-only configurations
vim.cmd([[ 
autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType markdown let b:AutoPairsSingleQuoteBalanceCheck = 0
]])

-- autocmd: Toggle 'relativenumber' when using INSERT mode
vim.cmd([[
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
]])

-- autocmd: Window's title
vim.cmd('autocmd VimEnter * set title')

-- editor: TAB -> 4 spaces 
vim.bo.tabstop = 8
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

-- editor: Use arrows to jump lines
vim.o.whichwrap = '<,>,[,]'

-- editor: Show line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- editor: No ESC delay
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0

-- editor: Statusline settings
vim.o.laststatus = 2
vim.o.showmode = false
vim.o.ruler = false

-- editor: Mouse features
vim.o.mouse = 'a'

-- editor: Don't wrap long lines
vim.wo.wrap = false

-- editor: Turn on insensitive case
vim.o.ignorecase = true

-- editor: Disable sign column
vim.wo.signcolumn = 'no'

-- editor: Hide buffers instead of closing them
vim.o.hidden = true

-- keybinding: Codeforces template
map('n', 'cpp', 'ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>17zt23gg', { noremap = true, silent = true })

-- keybinding: NERDTree / NERDCommenter
map('', '<C-n>', ':NERDTreeToggle<CR>', { silent = true })
map('', '<C-_>', '<plug>NERDCommenterToggle', {})

-- keybinding: Move line up/down
map('n', '<C-k>', ':m-2<CR>', { noremap = true, silent = true })
map('n', '<C-j>', ':m+<CR>',  { noremap = true, silent = true })

-- keybinding: Highlight keybindings
map('n', '<F3>', ':noh<CR>', { noremap = true, silent = true })
map('n', '<F4>', ':set ic<CR>:echo "Case-insensitive"<CR>', { noremap = true, silent = true })
map('n', '<F5>', ':set noic<CR>:echo "Case-sensitive"<CR>', { noremap = true, silent = true })

-- keybinding: Markdown Preview
map('n', '<F9>', '<plug>MarkdownPreview', {}) 

-- ui: True color
vim.o.termguicolors = true

-- ui: Colorscheme
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.cmd('colorscheme gruvbox-material')
vim.g.airline_theme = 'gruvbox_material'

-- ui: Operator highlight colors
--vim.g.ophigh_color_gui = '#8EC07C'
--vim.g.ophigh_color_gui_braces = '#ebdbb2'

-- ui: coc-nvim highlight
vim.cmd('highlight link SpecialChar Special')

-- ui: vim-lsp-cxx-highlight custom
vim.cmd([[
highlight default link LspCxxHlGroupNamespace cppSTLnamespace
highlight default link LspCxxHlSymVariable Normal
highlight link LspCxxHlGroupMemberVariable GruvboxBlue
highlight link cppSTLVariable LspCxxHlSymVariable
]])

