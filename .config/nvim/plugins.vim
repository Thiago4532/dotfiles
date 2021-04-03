" vim-plug
call plug#begin()

"" Linting
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Syntax Highlight
Plug 'sheerun/vim-polyglot' " Support many languages
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++
Plug 'Thiago4532/vim-operator-highlight' " Operator highlighting

"" UI
Plug 'vim-airline/vim-airline' " vim-airline
Plug 'vim-airline/vim-airline-themes' " themes for vim-airline
Plug 'arcticicestudio/nord-vim' " Vim Nord Theme
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " NERDTree syntax highlight


"" Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'preservim/nerdtree' " File explorer
"Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'preservim/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown

call plug#end()
