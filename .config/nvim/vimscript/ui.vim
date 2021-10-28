set termguicolors
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'

function! s:gruvbox_material_custom() abort
    highlight! link TSNamespace Purple
    highlight! link TSVariableBuiltin PurpleItalic
    highlight! clear TSError

    highlight! link TSString String
    highlight! link TSStringEscape SpecialChar
    highlight! link TSStringRegex SpecialChar

    highlight! link TSConditional Conditional
    highlight! link TSRepeat Repeat
    highlight! link TSException Exception
    highlight! link TSInclude Include

    " indent-blankline
    highlight IndentBlanklineChar guifg=#32302f gui=nocombine

    " Terminal
    let g:terminal_color_0  = '#32302f'
    let g:terminal_color_8  = '#504945'
    let g:terminal_color_11 = '#e78a4e'

    " Javascript
    highlight! link javascriptTSVariable Blue
    highlight! link javascriptTSParameter Blue

    " Vimwiki
    highlight! link textSnipTEX Special

    " lsp-semantic
    highlight! link LspSemanticNamespace TSNamespace
    highlight! link LspSemanticEnumMember TSStructure
    highlight! link LspSemanticParameter Blue
endfunction

augroup GruvboxMaterialCustom
    autocmd!
    autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

colorscheme gruvbox-material
