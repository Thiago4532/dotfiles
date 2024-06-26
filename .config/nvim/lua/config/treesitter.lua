-- local disabled_list = {'cuda', 'bash', 'zsh', 'haskell', 'vim', 'zig'}
local disabled_list = {'c', 'cpp', 'cuda', 'bash', 'zsh', 'haskell', 'vim', 'zig'}

require'nvim-treesitter.configs'.setup {
    auto_install = true,

    highlight = {
        enable = true,
        disable = disabled_list,
    },
    incremental_selection = {
        enable = true,
        disable = disabled_list,
    },
    playground = {
        enable = true,
        disable = disabled_list,
    },
    textobjects = {
        select = {
            enable = true,
            disable = disabled_list,

            lookahead = false,

            keymaps = {
                 ["af"] = "@function.outer",
                 ["if"] = "@function.inner",
                 ["ac"] = "@class.outer",
                 ["ic"] = "@class.inner",
            }
        },
    }
}
