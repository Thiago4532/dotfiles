local vim = vim
local util = require'lspconfig/util'
local is_executable = require'util'.is_executable

capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = 'utf-8'

-- C/C++
require'lspconfig'.clangd.setup {
    on_attach = function(client, bufnr)
        require'lsp-tree'.on_attach(client, bufnr)
    end,
    init_options = {
        fallbackFlags = {'-DTDEBUG', vim.fn.expand('-I/home/thiagomm/.local/include')},
    },
    capabilities = capabilities,
    root_dir = function(fname)
        local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
        local root_pattern = util.root_pattern('compile_commands.json', 'compile_flags.txt')

        return root_pattern(filename)
        or root_pattern(vim.loop.cwd())
    end,
    -- cmd = { "clangd", "--clang-tidy" },
}

-- Python
require'lspconfig'.pyright.setup{
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end
    },
    capabilities = capabilities
}

-- Rust
-- require'lspconfig'.rust_analyzer.setup{
--     capabilities = capabilities,
--     -- settings = {
--     --     ['rust-analyzer'] = {
--     --         ['diagnostics'] = {
--     --             ['warningsAsHint'] = {'unused_variables'}
--     --         }
--     --     }
--     -- },
--     root_dir = function(fname)
--         local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
--         local root_pattern = util.root_pattern('Cargo.toml')

--         return root_pattern(filename)
--     end
-- }

-- Golang
-- require'lspconfig'.gopls.setup{
--     capabilities = capabilities,
--     root_dir = function(fname)
--         local root_pattern = util.root_pattern('go.mod', '.git')

--         return root_pattern(fname)
--         or root_pattern(vim.fn.getcwd())
--         or util.path.dirname(fname)
--     end
-- }

-- JavaScript/TypeScript
-- require'lspconfig'.tsserver.setup{
--     handlers = {
--         ['textDocument/publishDiagnostics'] = function(id, result, ctx, config)
--             -- Diagnostics codes to ignore
--             local ignore_codes = {
--                 [80001] = true
--             }

--             result.diagnostics = vim.tbl_filter(function(diag)
--                 return not ignore_codes[diag.code]
--             end, result.diagnostics)

--             -- -- Add diagnostic's code to the message
--             -- for _, d in ipairs(result.diagnostics) do
--             --     d.message = string.format("%s (%d)", d.message, d.code)
--             -- end

--             return vim.lsp.handlers["textDocument/publishDiagnostics"](id, result, ctx, config)
--         end
--     }
-- }

-- Zig
-- require'lspconfig'.zls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false;
}
)

-- require'lsp_signature'.setup{
--     hint_enable = false,
--     toggle_key = '<C-k>',
-- }
