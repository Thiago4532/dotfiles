" vim-plug
call plug#begin()

" Linting
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Syntax Highlight
Plug 'sheerun/vim-polyglot' " Support many languages
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++
Plug 'Thiago4532/vim-operator-highlight' " Operator highlighting
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" UI
Plug 'Thiago4532/dtbg.nvim' " Dynamic Terminal Background Color
Plug 'vim-airline/vim-airline' " vim-airline
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " NERDTree syntax highlight

" Editing Plugins
Plug 'Krasjet/auto.pairs'
"Plug 'preservim/nerdtree' " File explorer
Plug 'preservim/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown

call plug#end()
