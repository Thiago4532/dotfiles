local vim = vim
local util = require'lspconfig/util'

funcao = function(fname)
    local root_pattern = util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt')

    return root_pattern(fname)
        or root_pattern(vim.fn.getcwd())
        or util.path.dirname(fname)
end,
require'lspconfig'.ccls.setup { 
    init_options = {
        index = {
            threads = 0;
        };
        highlight = {
            lsRanges = true;
        };
        cache = {
            directory = vim.fn.stdpath('cache')..'/ccls';
        };
    };
    root_dir = function(fname)
        local root_pattern = util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt')

        return root_pattern(fname)
            or root_pattern(vim.fn.getcwd())
            or util.path.dirname(fname)
    end,
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
