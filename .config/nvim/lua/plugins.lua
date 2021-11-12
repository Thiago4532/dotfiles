vim.cmd [[packadd packer.nvim]]
local packer = require'packer'

local function executable(...)
    for i=1,select('#', ...) do
        local arg = select(i, ...)
        if vim.fn.executable(arg) == 0 then
            return false
        end
    end
    return true
end

local nvim_nightly = (vim.fn.has("nvim-0.6") == 1)
return packer.startup({function()
    use {
        'wbthomason/packer.nvim',

        config = [[require'plugins']],
        cmd = { 'PackerInstall', 'PackerUpdate', 'PackerSync',
        'PackerClean', 'PackerCompile', 'PackerLoad', 'PackerProfile' }
    }

    use 'lewis6991/impatient.nvim'
    use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

    -- Syntax Highlighting
    use {
        {
            'nvim-treesitter/nvim-treesitter',
            branch = not nvim_nightly and '0.5-compat',
            config = [[require'config.treesitter']],
            requires = {
                {
                    'nvim-treesitter/playground',
                },
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                    branch = not nvim_nightly and '0.5-compat'
                }
            },

            run = ':TSUpdate',
        },

        'vim-jp/vim-cpp',
        'bfrg/vim-cpp-modern',

        'neovimhaskell/haskell-vim',
        'tikhomirov/vim-glsl',
    }

    -- Language Server Protocol
    use {
        'neovim/nvim-lspconfig',
        config = [[require'config.lsp']],

        requires = {
            { 'hrsh7th/nvim-cmp', config = [[require'config.complete']] },
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
            'ray-x/lsp_signature.nvim',
            'Thiago4532/lsp-semantic.nvim',
        }
    }

    -- Statusline and bufferline
    use {
        {
            'hoob3rt/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',

            config = [[require'config.statusline']],
        },
        {
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',

            config = [[require'config.bufferline']],
        }
    }

    -- Colorscheme
    use 'sainnhe/gruvbox-material'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',

        config = [[require'nvim-tree'.setup{}]],
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
    }

    use { 'Krasjet/auto.pairs', config = [[vim.g.AutoPairsOpenBalanceBlacklist = {'{'}]] }
    
    -- use { 'windwp/nvim-autopairs', config = [[require'nvim-autopairs'.setup{}]] }

    -- Editorconfig
    use { 'editorconfig/editorconfig-vim' }

    use {
        'b3nj5m1n/kommentary',

        config = [[require'config.kommentary']],
        keys = { {'n', 'gc'}, {'x', 'gc'}, {'n', 'gcc'} },
    }

    -- Fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },

        config = [[require'config.telescope']],
    }

    use {
        'tpope/vim-surround',

        setup = [[vim.g.surround_no_insert_mappings = 1]],
        keys = { { 'n', 'ds' }, { 'n', 'cs' }, { 'n', 'cS' }, { 'n', 'ys' }, { 'n', 'yS' },
            { 'n', 'ys' }, { 'n', 'yS' }, { 'n', 'yS' }, { 'x', 'S'  }, { 'x', 'gS' }
        }
    }

    -- Repeat commands using '.',
    use { 'tpope/vim-repeat' }

    use {
        'plasticboy/vim-markdown',
        opt = true,
        setup = [[
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_folding_disabled = 1
        vim.api.nvim_command'autocmd FileType markdown setlocal conceallevel=2'
        ]],

        ft = 'markdown',
        requires = { 'godlygeek/tabular' },
    }

    use { 'lambdalisue/suda.vim' }
    use { 'lukas-reineke/indent-blankline.nvim' }

    use { 'github/copilot.vim', cmd = 'Copilot' }

    use '/home/thiagomm/GitHub/lsp-tree.nvim'

    use { 'nathom/filetype.nvim', disable = not nvim_nightly }

    use { 
        'iamcco/markdown-preview.nvim',
        disable = not executable'yarn',

        run = 'cd app && yarn install',
    }
end,
config = {
    profile = {
        enable = false
    },
}})
