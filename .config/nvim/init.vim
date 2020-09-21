call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'Valloric/vim-operator-highlight'
Plug 'phanviet/vim-monokai-pro'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

let g:lightline = {
	  \ 'active': {
	  \  'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], [ 'statuslinetabs' ] ],
	  \  'right': [ [ 'lineinfo' ],
	  \             [ 'percent' ],
	  \             [ 'fileformat', 'fileencoding', 'filetype' ] ] 
      \ },
      \ 'component_function': {
      \   'statuslinetabs': 'LightlineStatuslineTabs'
      \ },
	  \ 'colorscheme': 'nord',
      \ }


function! LightlineStatuslineTabs() abort
  return "-> " . join(map(range(1, tabpagenr('$')),
        \ '(v:val == tabpagenr() ? "\uf15b " : "") . lightline#tab#filename(v:val)'), " \u2b81 ")
endfunction

" Use default syntax highlight
filetype indent plugin on
syntax on

" Set tab size
set tabstop=4
set softtabstop=4 
set shiftwidth=4

" Use arrows to move lines
set whichwrap+=<,>,[,]

" Set numbers before each line
"set number

" Remove ESC delay
set timeoutlen=200 ttimeoutlen=0

set showtabline=0
set laststatus=2
set noshowmode

nnoremap <C-M-Left> <C-w> <C-Left>

" Move line up/down ( Sublime Text 3 ) 
nnoremap <C-S-Up> :m-2<CR>
nnoremap <C-S-Down> :m+<CR>


"inoremap <C-S-Up> <Esc>:m-2<CR>
"inoremap <C-S-Down> <Esc>:m+<CR>

"nnoremap ; l
"nnoremap l k
"nnoremap k j
"nnoremap j h
"vnoremap ; l
"vnoremap l k
"vnoremap k j
"vnoremap j h

nnoremap <F3> :noh<CR>
nnoremap <F4> :set ic<CR>
nnoremap <F5> :set noic<CR>

set ic

nnoremap <C-S-Left> :tabp<CR>
nnoremap <C-S-Right> :tabn<CR>
inoremap <C-S-Left> <Esc>:tabp<CR>
inoremap <C-S-Right> <Esc>:tabn<CR>

nnoremap <C-S-kPlus> :m-2

nnoremap <C-Down> <C-e>
nnoremap <C-Up> <C-y>
inoremap <C-Down> <C-e>
inoremap <C-Up> <C-y>

nmap <C-_> <plug>NERDCommenterInvert
vmap <C-_> <plug>NERDCommenterComment

nm <silent> <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>

set mouse=a
set number
set termguicolors

"colorscheme nord
colorscheme monokai_nord


let g:ophigh_color_gui = "#8fbcbb"
"hi LineNr guibg=NONE guifg=#7c74b3
"colorscheme nord

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
"set guicursor=
"let g:ycm_autoclose_preview_window_after_insertion = 1
"set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 0

"let g:ycm_min_num_of_chars_for_completion = 4
"let g:ycm_min_num_identifier_candidate_chars = 4
"let g:ycm_filetype_whitelist = {'javascript': 1}
"let g:ycm_auto_trigger = 1
"let g:ctrlp_prompt_mappings = {
"    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
"    \ 'AcceptSelection("t")': ['<cr>'],
"    \ }
