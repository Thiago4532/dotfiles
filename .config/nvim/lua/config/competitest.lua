require'competitest'.setup {
    compile_command = {
        cpp = { exec = 'rr', args = { '-n', '$(FNOEXT)' } }
    }
}

local function map(lhs, rhs)
    return vim.keymap.set('n', lhs, rhs, { silent = true })
end

map(';', ":lua require('telescope.builtin').buffers()<cr>")
map('<F5>', ':CompetiTest run<CR>')
map('<F8>', ':CompetiTest receive testcases<CR>')

