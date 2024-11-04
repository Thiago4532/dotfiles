local normal_mode = {
    initial_mode = "normal"
}

require'telescope'.setup{
    defaults = {
        mappings = {
            n = { ["<c-c>"] = "close" },
        },
        file_ignore_patterns = { 'LICENSE' },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["<c-d>"] = "delete_buffer" }
            },
            -- initial_mode = "normal"
        }, 
        lsp_references = normal_mode,
        lsp_implementations = normal_mode,
        lsp_definitions = normal_mode,
        lsp_type_definitions = normal_mode,
        lsp_workspace_diagnostics = normal_mode,
        lsp_code_actions = normal_mode,
    }
}

require("telescope").load_extension("ui-select")

-- Keybindings
local function map(lhs, rhs)
    return vim.keymap.set('n', lhs, rhs, { silent = true })
end

map(';', ":lua require('telescope.builtin').buffers()<cr>")
map('ç', ":lua require('telescope.builtin').buffers()<cr>")
map('<C-p>', ":lua require('telescope.builtin').find_files()<cr>")
map('<leader>m', ":lua require('telescope.builtin').marks()<cr>")
map('<C-p>', ":lua require('telescope.builtin').find_files()<cr>")
map('<space>g', ":lua require('telescope.builtin').live_grep()<cr>")
map('<space>h', ":lua require('telescope.builtin').help_tags()<cr>")
map('""', ":lua require('telescope.builtin').registers()<cr>")
map('gD', ":lua vim.lsp.buf.declaration()<CR>")
map('gd', ":lua require'telescope.builtin'.lsp_definitions()<CR>")
map('<leader>D', ":lua require'telescope.builtin'.lsp_type_definitions()<CR>")
map('gi', ":lua require'telescope.builtin'.lsp_implementations()<CR>")
map('gr', ":lua require'telescope.builtin'.lsp_references()<CR>")
map('<space>d', ":lua require'telescope.builtin'.lsp_document_symbols()<CR>")
map('<leader>A', ":lua vim.lsp.buf.code_action()<CR>")
map('<space>E', ":lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>")
