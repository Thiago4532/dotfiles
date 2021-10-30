return require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'c', 'cpp', 'bash', 'haskell', 'vim'}
    },
    incremental_selection = {
        enable = true,
    },
    playground = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,

            lookahead = true,

            keymaps = {
                 ["af"] = "@function.outer",
                 ["if"] = "@function.inner",
                 ["ac"] = "@class.outer",
                 ["ic"] = "@class.inner",
            }
        }
    }
}
