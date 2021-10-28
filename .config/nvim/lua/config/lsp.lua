local vim = vim
local util = require'lspconfig/util'

-- require'lspconfig'.ccls.setup { 
--     init_options = {
--         index = {
--             threads = 0;
--         };
--         highlight = {
--             lsRanges = true;
--         };
--         cache = {
--             directory = vim.fn.stdpath('cache')..'/ccls';
--         };
--     };
--     root_dir = function(fname)
--         local root_pattern = util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt')

--         return root_pattern(fname)
--         or root_pattern(vim.fn.getcwd())
--         or util.path.dirname(fname)
--     end,
-- }

require'lspconfig'.clangd.setup {
    before_init = require'lsp-semantic.configs'.clangd.before_init,
    root_dir = function(fname)
        local root_pattern = util.root_pattern('compile_commands.json', 'compile_flags.txt')

        return root_pattern(fname)
        or root_pattern(vim.fn.getcwd())
        or util.path.dirname(fname)
    end
}

require'lspconfig'.jedi_language_server.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false;
}
)
