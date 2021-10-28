return require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {'c', 'cpp', 'bash', 'haskell', 'vim'}
    },
    playground = {
        enable = true,
    },
}
