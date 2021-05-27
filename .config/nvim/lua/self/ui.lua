-- ui: True color
vim.o.termguicolors = true

-- ui: Colorscheme
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

vim.cmd'colorscheme gruvbox-material'

-- ui: vim-lsp-cxx-highlight custom
vim.cmd([[
highlight default link LspCxxHlGroupNamespace cppSTLnamespace
highlight default link LspCxxHlSymVariable Normal
highlight link cppSTLVariable LspCxxHlSymVariable
]])
