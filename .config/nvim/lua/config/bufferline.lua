return require'bufferline'.setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- diagnostics = 'nvim_lsp',
        diagnostics = false, -- TODO: Temporary fix
    },
    highlights = {
        fill = {
            guibg = '#191919'
        },
    }
}
