" vim-plug
call plug#begin()

" Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" Syntax Highlight
Plug 'sheerun/vim-polyglot' " Support many languages
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++

" UI
Plug 'Thiago4532/dtbg.nvim' " Dynamic Terminal Background Color
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
"Plug 'ryanoasis/vim-devicons' " Icons
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Utility
Plug 'famiu/nvim-reload' " Reload plugins

" Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'preservim/nerdcommenter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " Markdown

" Neovim LUA Development
Plug 'nvim-lua/plenary.nvim' 

call plug#end()
