return require'lualine'.setup {
    options = {
        theme = 'gruvbox-material'
    },
    sections = {
        lualine_b = {
            'branch',
            {
                'diff',
                diff_color = {
                    added = { fg = '#a9b665' },
                    modified = { fg = '#7daea3' },
                    removed = { fg = '#ea6962' },
                }
            }
        },
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_diagnostic'},
                sections = {'error', 'warn'},
                diagnostics_color = {
                    error = { fg = '#ea6962' },
                    warn = { fg = '#d8a657' }
                }
            },
            'encoding',
            'fileformat',
            'filetype'
        },
    },
    extensions = {'nvim-tree'}
}
