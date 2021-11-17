local vim = vim
local util = require'lspconfig/util'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- C/C++
require'lspconfig'.clangd.setup {
    before_init = require'lsp-semantic.configs'.clangd.before_init,
    on_attach = require'lsp-tree'.on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
        local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
        local root_pattern = util.root_pattern('compile_commands.json', 'compile_flags.txt')

        return root_pattern(filename)
        or root_pattern(vim.loop.cwd())
    end
}

-- Python
require'lspconfig'.jedi_language_server.setup{
    capabilities = capabilities
}

-- Golang
require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    root_dir = function(fname)
        local root_pattern = util.root_pattern('go.mod', '.git')

        return root_pattern(fname)
        or root_pattern(vim.fn.getcwd())
        or util.path.dirname(fname)
    end
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false;
}
)

-- require'lsp_signature'.setup{
--     hint_enable = false,
--     toggle_key = '<C-k>',
-- }
