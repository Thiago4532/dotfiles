" === Plugin configuration ===
let mapleader=','

" === vim-airline ===

let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
let g:airline#extensions#whitespace#enabled = 0

" =/= vim-airline =/=

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

" Set TAB size to 4
set tabstop=4 softtabstop=4 shiftwidth=4

" Use arrows to jump lines
set whichwrap+=<,>,[,]

" Enable line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Disable ESC delay
set timeoutlen=500 ttimeoutlen=0

" Statusline editor settings
set laststatus=2
set noshowmode

" Disable mouse features
set mouse=

" Do not wrap long lines
"set nowrap

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
"nnoremap <silent> <C-S-Up> :m-2<CR>
"nnoremap <silent> <C-S-Down> :m+<CR>

" Search highlight options
nnoremap <silent> <F3> :noh<CR>
nnoremap <silent> <F4> :set ic<CR>
nnoremap <silent> <F5> :set noic<CR>

" Disable arrow keys
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>

nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>

nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>

nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>

" Move between buffers using Control+Shift+Arrows
"nnoremap <silent> <C-S-Left> :bp<CR>
"nnoremap <silent> <C-S-Right> :bn<CR>

nnoremap <silent> <C-h> :bp<CR>
nnoremap <silent> <C-l> :bn<CR>

nnoremap <silent> <S-Up> :echo "Nope!."<CR>
nnoremap <silent> <S-Down> :echo "Nope!."<CR>
nnoremap <silent> <S-Left> :echo "Nope!."<CR>
nnoremap <silent> <S-Right> :echo "Nope!."<CR>

" Vertical scrolling using Control + Arrows
"nnoremap <C-Down> <C-e>
"nnoremap <C-Up> <C-y>
"inoremap <C-Down> <C-e>
"inoremap <C-Up> <C-y>

" Horizontal scrolling using Control + Arrows
nnoremap <C-Right> zL
nnoremap <C-Left> zH

" Print highlight groups
nm <silent> <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
	\ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
	\ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
	\ . ">"<CR>


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
"hi link LspCxxHlSymMacro Constant
