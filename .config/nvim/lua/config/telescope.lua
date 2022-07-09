local normal_mode = {
    initial_mode = "normal"
}

require'telescope'.setup{
    defaults = {
        mappings = {
            n = { ["<c-c>"] = "close" },
        }
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["<c-d>"] = "delete_buffer" }
            },
            initial_mode = "normal"
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
