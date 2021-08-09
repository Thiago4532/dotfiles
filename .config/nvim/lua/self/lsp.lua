local vim = vim

require'lspconfig'.ccls.setup { 
    init_options = {
        index = {
            threads = 0;
        };
        highlight = {
            lsRanges = true;
        };
        cache = {
            directory = vim.fn.expand('~/.cache/ccls-cache');
        };
    };
    no_wait = true;
}

require'lspconfig'.jedi_language_server.setup{}

-- require'lspconfig'.tsserver.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- vim.cmd([[
-- autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
-- autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
-- ]])
