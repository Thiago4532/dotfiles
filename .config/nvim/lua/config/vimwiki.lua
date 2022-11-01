local vim = vim

vim.g.vimwiki_list = {{
    path = '~/Documents/vimwiki', path_html = '~/Documents/HTML'
}}

vim.g.vimwiki_ext2syntax = {
    ['.md'] = 'markdown',
    ['.mkdn'] = 'markdown',
    ['.mdwn'] = 'markdown',
    ['.mdown'] = 'markdown',                         
    ['.markdown'] = 'markdown',
    ['.rmd'] = 'markdown',
    ['.mw'] = 'media',
}
