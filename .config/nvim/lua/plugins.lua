vim.cmd [[packadd packer.nvim]]
local packer = require'packer'
local executable = require'util'.is_executable

-- local nvim_nightly = (vim.fn.has("nvim-0.7") == 1)
return packer.startup({function()
    use {
        'wbthomason/packer.nvim',

        config = [[require'plugins']],
        cmd = { 'PackerInstall', 'PackerUpdate', 'PackerSync',
        'PackerClean', 'PackerCompile', 'PackerLoad', 'PackerProfile' }
    }

    use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

    -- Syntax Highlighting
    use {
        {
            'nvim-treesitter/nvim-treesitter',
            -- branch = not nvim_nightly and '0.5-compat' or nil,
            config = [[require'config.treesitter']],
            requires = {
                {
                    'nvim-treesitter/playground',
                },
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                    -- branch = not nvim_nightly and '0.5-compat' or nil
                }
            },

            run = function()
                local ts_update = require'nvim-treesitter.install'.update({with_sync = true})
                ts_update()
            end
        },

        'vim-jp/vim-cpp',
        'bfrg/vim-cpp-modern',
        'neoclide/vim-jsx-improve',
        'HerringtonDarkholme/yats.vim',

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
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'ray-x/lsp_signature.nvim',
        }
    }

    -- Statusline and bufferline
    use {
        -- {
            'hoob3rt/lualine.nvim',
            requires = 'kyazdani42/nvim-web-devicons',

            config = [[require'config.statusline']],
        -- },
        -- {
        --     'akinsho/bufferline.nvim',
        --     requires = 'kyazdani42/nvim-web-devicons',

        --     config = [[require'config.bufferline']],
        -- }
    }

    -- Colorscheme
    use 'sainnhe/gruvbox-material'
    use 'folke/tokyonight.nvim'

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',

        config = [[require'nvim-tree'.setup{}]],
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle', 'NvimTreeClose' },
    }

    -- use { 'Krasjet/auto.pairs', config = [[vim.g.AutoPairsOpenBalanceBlacklist = {'{'}]] }
    
    use { 'windwp/nvim-autopairs' }

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
        'nvim-telescope/telescope-ui-select.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
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

    -- use {
    --     'Thiago4532/vim-markdown',
    --     opt = true,
    --     setup = [[
    --     vim.g.vim_markdown_math = 1
    --     vim.g.vim_markdown_folding_disabled = 1
    --     vim.g.vim_markdown_follow_anchor = 1
    --     vim.api.nvim_command'autocmd FileType markdown setlocal conceallevel=2'
    --     ]],

    --     ft = 'markdown',
    --     requires = { 'godlygeek/tabular' },
    -- }
    
    use {
        'vimwiki/vimwiki',

        setup = [[require'config.vimwiki']],
        event = 'BufNewFile,BufReadPre *.wiki,*.markdown,*.md,*.rmd',
    }

    use { 'lambdalisue/suda.vim' }
    -- use { 'lukas-reineke/indent-blankline.nvim' }

    use { 'mbbill/undotree', config = [[vim.g.undotree_WindowLayout = 3]] }

    use { 'famiu/bufdelete.nvim' }

    use { 'phaazon/hop.nvim', config = [[require'config.hop']] }

    use { 
        'iamcco/markdown-preview.nvim',
        filetype = 'md',
        disable = not executable'yarn',

        run = 'cd app && yarn install',
    }

    use 'Thiago4532/lsp-tree.nvim'
    use 'Thiago4532/header-guard.nvim'

    use { 'ThePrimeagen/harpoon', config = [[require'config.harpoon']] }

    use 'jghauser/mkdir.nvim'

    use { 'stevearc/aerial.nvim', config = [[require'config.aerial']] }
    -- use { 'edluffy/hologram.nvim' }
end,
config = {
    profile = {
        enable = false,
    },
}})
