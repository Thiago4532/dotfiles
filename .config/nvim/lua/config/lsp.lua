local vim = vim
local util = require'lspconfig/util'
local cmp = require'cmp'

cmp.setup {
    completion = {
        autocomplete = false,
    },
    sources = {
        { name = 'nvim_lsp' },
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'lspconfig'.clangd.setup {
    before_init = require'lsp-semantic.configs'.clangd.before_init,
    capabilities = capabilities,
    root_dir = function(fname)
        local root_pattern = util.root_pattern('compile_commands.json', 'compile_flags.txt')

        return root_pattern(fname)
        or root_pattern(vim.fn.getcwd())
        or util.path.dirname(fname)
    end
}

require'lspconfig'.jedi_language_server.setup{
    capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false;
}
)

require'lsp_signature'.setup{
    hint_enable = false,
    toggle_key = '<C-k>'
}
