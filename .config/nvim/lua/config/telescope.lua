require'telescope'.setup{
    defaults = {
        file_ignore_patterns = {'build/.*', 'compile_commands.json'},
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["<c-d>"] = "delete_buffer", ["<c-c>"] = "close" }
            },
            initial_mode = "normal"
        }
    }
}
