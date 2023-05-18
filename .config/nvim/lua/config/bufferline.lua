require'bufferline'.setup{
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- diagnostics = 'nvim_lsp',
        diagnostics = false, -- TODO: Temporary fix
    },
    highlights = {
        fill = {
            bg = '#191919'
        },
    }
}

-- Keybindings
local function map(lhs, rhs)
    return vim.keymap.set('n', lhs, rhs, {silent = true})
end

map('<C-h>', ':BufferLineCyclePrev<CR>')
map('<C-l>', ':BufferLineCycleNext<CR>')
map('H', ':bp<CR>')
map('L', ':bl<CR>')
map('<leader>1', ':BufferLineGoToBuffer 1<CR>')
map('<leader>2', ':BufferLineGoToBuffer 2<CR>')
map('<leader>3', ':BufferLineGoToBuffer 3<CR>')
map('<leader>4', ':BufferLineGoToBuffer 4<CR>')
map('<leader>5', ':BufferLineGoToBuffer 5<CR>')
map('<leader>6', ':BufferLineGoToBuffer 6<CR>')
map('<leader>7', ':BufferLineGoToBuffer 7<CR>')
map('<leader>8', ':BufferLineGoToBuffer 8<CR>')
map('<leader>9', ':BufferLineGoToBuffer 9<CR>')
