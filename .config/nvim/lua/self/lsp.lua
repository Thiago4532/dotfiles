require'lspconfig'.ccls.setup { 
    init_options = {
        compilationDatabaseDirectory = 'build';
        index = {
            threads = 0;
        };
        highlight = {
            lsRanges = true;
        };
        cache = {
            directory = vim.fn.expand('~') .. '/.cache/ccls-cache';
        };
    };
    no_wait = true;
}

require'lspconfig'.tsserver.setup{}
