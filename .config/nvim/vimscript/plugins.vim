" vim-plug
call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'tweekmonster/startuptime.vim'
Plug 'gennaro-tedesco/nvim-peekup'

" " Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" " Syntax Highlight
" Plug 'sheerun/vim-polyglot'
Plug 'vim-jp/vim-cpp'
Plug 'bfrg/vim-cpp-modern'
Plug 'jackguo380/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++

" " UI
Plug 'sainnhe/gruvbox-material'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'

" " Editing Plugins
Plug 'Krasjet/auto.pairs'
Plug 'b3nj5m1n/kommentary'
Plug 'tpope/vim-surround'

" " Neovim LUA Development
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-lua/popup.nvim'

" " Taking notes
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'oberblastmeister/neuron.nvim', { 'branch': 'unstable' }

call plug#end()
