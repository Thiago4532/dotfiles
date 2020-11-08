" === Plugin configuration ===
let mapleader=','

" === vim-airline ===

let b:AutoPairsOpenBalanceBlacklist = ['{']
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
let g:airline#extensions#whitespace#enabled = 0

" =/= vim-airline =/=

let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-rust-analyzer']

" === NERDTree ===

" Default NERDTree window's size
let NERDTreeWinSize=28

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" HighlightFullName
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" =/= NERDTree =/=

" === vim-better-whitespace
let g:better_whitespace_guicolor = "#E06C75"

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
" =/= vim-better-whitespace =/=

" Enable plugins (vim-plug)
source ~/.config/nvim/plugins.vim

" === Editor settings ===

" Set TAB to 4 spaces
set tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" Use arrows to jump lines
set whichwrap+=<,>,[,]

" Enable line numbers
set number relativenumber

" Enable .nvimrc files
set exrc
set secure

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Disable coc-nvim when using markdown
autocmd FileType markdown let b:coc_suggest_disable = 1

autocmd FileType markdown let b:AutoPairsSingleQuoteBalanceCheck = 0

" Disable ESC delay
set timeoutlen=500 ttimeoutlen=0

" Statusline editor settings
set laststatus=2
set noshowmode

" Enable mouse features
set mouse=a

" Do not wrap long lines
set nowrap

" Insensitive Case by default
set ic

" Limit suggestions size to 15
set pumheight=15

" Disable sign column
set signcolumn=no

set hidden

" === Keybindings ===

" Open NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-_> <plug>NERDCommenterToggle

" Move line up/down ( Sublime Text 3 )
nnoremap <silent> <C-k> :m-2<CR>
nnoremap <silent> <C-j> :m+<CR>

" Duplicate line
nnoremap <silent> <leader>d :t.<CR>
nnoremap <silent> <leader>D :t-<CR>

" Search highlight options
nnoremap <silent> <F3> :noh<CR>
nnoremap <F4> :set ic<CR>
nnoremap <F5> :set noic<CR>

"nnoremap <silent> <C-h> :bp<CR>
"nnoremap <silent> <C-l> :bn<CR>

" Horizontal scrolling using Control + Arrows
nnoremap <C-Right> zL
nnoremap <C-Left> zH

" Print highlight groups
nm <silent> <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
	\ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
	\ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
	\ . ">"<CR>


nmap <F9> <Plug>MarkdownPreview

" === UI ===

" Use gui colors instead of terminal colors
set termguicolors

" Use default syntax highlight
set autoindent
filetype indent plugin on
syntax on

" Vim colorscheme

"let g:onedark_terminal_italics=1
colorscheme nord
hi Normal guibg=None ctermbg=None
hi CursorLineNr guifg=#81A1C1 gui=bold

" coc-nvim highlight
hi link SpecialChar Special
hi CocWarningSign guifg=#ebcb8b
hi CocErrorSign guifg=#bf616a

" Operator highlight
let g:ophigh_color_gui = "#81A1C1"
let g:ophigh_color_gui_braces = "#D8DEE9"

" vim-airline colorscheme
let g:airline_theme="nord"

" Custom highlight
hi Type gui=italic
hi Pmenu guibg=#292d38 guifg=#ebcb8b

hi link LspCxxHlGroupNamespace cppSTLnamespace
hi clear cppSTLVariable
hi cppSTLType guifg=#8fbcbb
hi link LspCxxHlSymClass cppSTLType
hi link LspCxxHlSymStruct cppSTLType
hi link LspCxxHlSymEnum cppSTLType
hi link LspCxxHlSymTypeAlias cppSTLType
hi link LspCxxHlSymTypeParameter cppSTLType
hi link LspCxxHlGroupMemberVariable Normal
"hi link LspCxxHlSymMacro Constant
