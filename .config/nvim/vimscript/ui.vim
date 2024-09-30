set termguicolors
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'

function! s:gruvbox_material_custom() abort
    highlight link TSNamespace Purple
    highlight link TSVariableBuiltin PurpleItalic
    " highlight! clear TSError

    " indent-blankline
    highlight IndentBlanklineChar guifg=#32302f gui=nocombine

    " Terminal
    let g:terminal_color_0  = '#32302f'
    let g:terminal_color_8  = '#504945'
    let g:terminal_color_11 = '#e78a4e'

    " lsp-semantic
    highlight link LspSemanticNamespace TSNamespace
    highlight link LspSemanticEnumMember TSStructure
    highlight link LspSemanticParameter Blue

    " render-markdown
    highlight RenderMarkdownH1Bg guibg=#3b2e2e
    highlight RenderMarkdownH2Bg guibg=#3b322c
    highlight RenderMarkdownH3Bg guibg=#3a352d
    highlight RenderMarkdownH4Bg guibg=#35362e
    highlight RenderMarkdownH5Bg guibg=#303534
    highlight RenderMarkdownH6Bg guibg=#393134
endfunction

augroup GruvboxMaterialCustom
    autocmd!
    autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

colorscheme gruvbox-material
