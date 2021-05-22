" vim-plug
call plug#begin()

" Language Server Protocol
"Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'neovim/nvim-lspconfig'

" Syntax Highlight
Plug 'sheerun/vim-polyglot' " Support many languages
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++
"Plug 'Thiago4532/vim-operator-highlight' " Operator highlighting

" UI
Plug 'Thiago4532/dtbg.nvim' " Dynamic Terminal Background Color
Plug 'vim-airline/vim-airline' " vim-airline
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " NERDTree syntax highlight

" Utility
Plug 'famiu/nvim-reload' " Reload plugins

" Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'preservim/nerdtree' " File explorer
Plug 'preservim/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown

" Neovim LUA Development
Plug 'nvim-lua/plenary.nvim' " All the lua functions I don't want to write twice

call plug#end()
