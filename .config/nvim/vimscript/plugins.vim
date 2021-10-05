" vim-plug
call plug#begin()

" " Language Server Protocol
Plug 'neovim/nvim-lspconfig'

" " Syntax Highlight
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat' ,'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'vim-jp/vim-cpp'
Plug 'bfrg/vim-cpp-modern'
Plug 'akinsho/bufferline.nvim'
Plug 'tikhomirov/vim-glsl'
Plug 'neovimhaskell/haskell-vim'
Plug 'Thiago4532/vim-lsp-cxx-highlight' " Semantic syntax highlighting for C/C++

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
Plug 'tpope/vim-repeat'

" " Neovim LUA Development
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-lua/popup.nvim'

" " Taking notes
Plug 'vimwiki/vimwiki'

call plug#end()
