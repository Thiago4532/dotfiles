" vim-plug
call plug#begin()

Plug 'tweekmonster/startuptime.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" Syntax Highlight
Plug 'sheerun/vim-polyglot'
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++

" UI
Plug 'Thiago4532/dtbg.nvim' " Dynamic Terminal Background Color
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'

" Utility
" Plug 'famiu/nvim-reload' " Reload plugins

" Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'b3nj5m1n/kommentary'

" Neovim LUA Development
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-lua/popup.nvim'

call plug#end()
