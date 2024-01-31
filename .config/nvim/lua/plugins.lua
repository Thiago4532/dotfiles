-- TODO: In the future, use a more modular setup instead of loading everything
-- when requiring the configuration (similiar to what all plugins do using a setup function

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function from_module(name)
    return function() require('config.' .. name) end
end

require'lazy'.setup {
    -- Syntax Highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        config = from_module 'treesitter',
        dependencies = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate'
    },

    'vim-jp/vim-cpp',
    'bfrg/vim-cpp-modern',
    'neoclide/vim-jsx-improve',
    'HerringtonDarkholme/yats.vim',

    'neovimhaskell/haskell-vim',
    'tikhomirov/vim-glsl',

    -- Language Server Protocol
    { 
        'neovim/nvim-lspconfig',
        config = from_module 'lsp',

        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            -- 'ray-x/lsp_signature.nvim',
        }
    },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        config = from_module 'nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        }
    },

    -- Statusline and bufferline
    {
        'hoob3rt/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',

        config = from_module 'statusline',
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',

        config = from_module 'bufferline',
    },

    -- Colorscheme
    'sainnhe/gruvbox-material',
    -- 'folke/tokyonight.nvim',

    -- File explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = 'kyazdani42/nvim-web-devicons',

        config = from_module 'nvim-tree',
    },

    -- use { 'Krasjet/auto.pairs', config = [[vim.g.AutoPairsOpenBalanceBlacklist = {'{'}]] }
    
    'windwp/nvim-autopairs',

    {
        'b3nj5m1n/kommentary',

        config = from_module 'kommentary',
        keys = {
            { 'gc', mode = {'n', 'x'} },
            { 'gcc' }
        },
    },

    -- Fuzzy finding
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },

        config = from_module 'telescope',
    },

    {
        'tpope/vim-surround',

        init = function() vim.g.surround_no_insert_mappings = 1 end,
        keys = { 'ds', 'cs', 'cS', 'ys', 'yS',
            'ys', 'yS', 'yS', { 'S', mode = 'x'  }, { 'gS', mode = 'x' }
        }
    },

    -- Repeat commands using '.',
    'tpope/vim-repeat',

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
    
    {
        'vimwiki/vimwiki',

        init = from_module 'vimwiki',
        event = {
            'BufNewFile *.wiki,*.md,*.mkdn,*.mdwn,*.mdown,*.markdown,*.rmd,*.mw',
            'BufReadPre *.wiki,*.md,*.mkdn,*.mdwn,*.mdown,*.markdown,*.rmd,*.mw',
        }
    },

    'lambdalisue/suda.vim',

    -- {
    --     'lukas-reineke/indent-blankline.nvim',
    --     config = function() require'ibl'.setup{} end
    -- },

    { 'mbbill/undotree', config = function() vim.g.undotree_WindowLayout = 3 end },

    'famiu/bufdelete.nvim',

    { 'phaazon/hop.nvim', config = from_module 'hop' },

    {
        'wallpants/github-preview.nvim',
        cmd = { 'GithubPreviewToggle' },
        keys = { '<leader>mt', '<leader>ms', '<leader>md', '<F9>' },
        config = from_module 'github-preview'
    },

    'Thiago4532/lsp-tree.nvim',
    'Thiago4532/header-guard.nvim',

    { 'ThePrimeagen/harpoon', config = from_module 'harpoon' },

    'jghauser/mkdir.nvim',

    { 'stevearc/aerial.nvim', config = from_module 'aerial' },
    
    { 'github/copilot.vim', init = from_module 'copilot' },

    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = from_module 'competitest',
    }
}
