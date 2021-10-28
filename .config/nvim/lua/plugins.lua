local nvim_nightly = (vim.fn.has("nvim-0.6") == 1)

local function backwards_compatibility(var)
    if nvim_nightly then
        return nil
    end
    return var
end

return require'packer'.startup(function()
    use {
        'wbthomason/packer.nvim',

        config = [[require'plugins']],
        cmd = { 'PackerInstall', 'PackerUpdate', 'PackerSync',
        'PackerClean', 'PackerCompile', 'PackerLoad', 'PackerProfile' }
    }

    use 'lewis6991/impatient.nvim'
    use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }

    -- Syntax Highlighting
    use {
        {
            'nvim-treesitter/nvim-treesitter',
            branch = backwards_compatibility('0.5-compat'),
            config = [[require'config.treesitter']],
            requires = {
                'nvim-treesitter/playground',
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                    branch = backwards_compatibility('0.5-compat')
                }
            },

            run = ':TSUpdate'
        },

        'vim-jp/vim-cpp',
        'bfrg/vim-cpp-modern',

        'neovimhaskell/haskell-vim',
        'tikhomirov/vim-glsl'
    }

    -- Language Server Protocol
    use { 'neovim/nvim-lspconfig', config = [[require'config.lsp']] }

    -- Statusline and bufferline
    use {
        {
            'hoob3rt/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',

            config = [[require'config.statusline']]
        },
        {
            'akinsho/bufferline.nvim',
            requires = 'kyazdani42/nvim-web-devicons',

            config = [[require'config.bufferline']]
        }
    }

    -- Colorscheme
    use 'sainnhe/gruvbox-material'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',

        config = [[require'nvim-tree'.setup{}]],
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle' }
    }

    use { 'Krasjet/auto.pairs', config = [[vim.g.AutoPairsOpenBalanceBlacklist = {'{'}]] }

    -- Editorconfig
    use { 'editorconfig/editorconfig-vim' }

    use {
        'b3nj5m1n/kommentary',

        config = [[require'config.kommentary']],
        keys = { {'n', 'gc'}, {'x', 'gc'}, {'n', 'gcc'} }
    }

    -- Fuzzy finding
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },

        config = [[require'config.telescope']]
    }

    use {
        'tpope/vim-surround',

        setup = [[vim.g.surround_no_insert_mappings = 1]],
        keys = { { 'n', 'ds' }, { 'n', 'cs' }, { 'n', 'cS' }, { 'n', 'ys' }, { 'n', 'yS' },
            { 'n', 'ys' }, { 'n', 'yS' }, { 'n', 'yS' }, { 'x', 'S'  }, { 'x', 'gS' }
        }
    }

    -- Repeat commands using '.'
    use { 'tpope/vim-repeat' }

    -- Personal wiki
    use {
        'vimwiki/vimwiki',

        setup = [[vim.g.vimwiki_list = {{path = '~/Documents/vimwiki', path_html = '~/Documents/HTML'}}]],
    }

    use { 'lambdalisue/suda.vim' }
    use { 'lukas-reineke/indent-blankline.nvim' }

    use '/home/thiagomm/GitHub/lsp-semantic.nvim'
end)
