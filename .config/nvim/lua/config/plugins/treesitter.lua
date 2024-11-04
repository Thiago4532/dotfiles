local ts_disabled = {'c', 'cpp', 'cuda'}
tm_opts.ts_disabled = ts_disabled

local highlight_disabled = {'bash', 'zsh', 'haskell', 'vim', 'zig'}
for _, v in ipairs(ts_disabled) do
    highlight_disabled[#highlight_disabled + 1] = v
end

require'nvim-treesitter.configs'.setup {
    auto_install = true,

    highlight = {
        enable = true,
        disable = highlight_disabled
    },
    indent = {
        enable = true,
        disable = ts_disabled
    },
    -- incremental_selection = {
    --     enable = true,
    --     disable = ts_disabled,
    -- },
    -- playground = {
    --     enable = true,
    --     disable = ts_disabled,
    -- },
    textobjects = {
        select = {
            enable = true,
            disable = ts_disabled,

            lookahead = false,

            keymaps = {
                 ["af"] = "@function.outer",
                 ["if"] = "@function.inner",
                 ["ac"] = "@class.outer",
                 ["ic"] = "@class.inner",
            }
        },
    },
}
