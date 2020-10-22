" vim-plug

call plug#begin()

" Syntax Highlight
Plug 'sheerun/vim-polyglot' " Support many languages
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++
Plug 'Thiago4532/vim-operator-highlight' " Operator highlighting

"" UI
Plug 'itchyny/lightline.vim' " Lightline VIM
Plug 'vim-airline/vim-airline' " vim-airline
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
Plug 'arcticicestudio/nord-vim' " Vim Nord Theme
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " NERDTree syntax highlight

"" Linting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc-nvim: LSP support, VSCode Extensions

"" Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'preservim/nerdtree' " File explorer
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdcommenter'

call plug#end()
