return require'lualine'.setup {
    options = {
        theme = 'gruvbox_material'
    },
    sections = {
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                sections = {'error', 'warn'},
                color_error = '#ea6962',
                color_warn = '#d8a657'
            },
            'encoding',
            'fileformat',
            'filetype'
        },
    },
    extensions = {'nvim-tree'}
}
