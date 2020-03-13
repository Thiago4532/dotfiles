call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Valloric/vim-operator-highlight'
Plug 'phanviet/vim-monokai-pro'
Plug 'preservim/nerdcommenter'

call plug#end()

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], [ 'statuslinetabs' ] ]
      \ },
      \ 'component_expand': {
      \   'statuslinetabs': 'LightlineStatuslineTabs',
      \ },
      \ }

function! LightlineStatuslineTabs() abort
  return join(map(range(1, tabpagenr('$')),
        \ '(v:val == tabpagenr() ? "\uf15b " : "") . lightline#tab#filename(v:val)'), " \u2b81 ")
endfunction

" Use default syntax highlight
filetype indent plugin on
syntax on

" Set tab size to 4
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
colorscheme monokai_pro
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNr guibg=NONE guifg=#7c74b3

"set guicursor=
