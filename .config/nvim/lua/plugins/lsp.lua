local vim = vim

local servers = {}

-- C/C++
servers.clangd = {
    -- on_attach = function(client, bufnr)
    --     require'lsp-tree'.on_attach(client, bufnr)
    -- end,
    capabilities = { offsetEncoding = 'utf-8' },
    init_options = {
        fallbackFlags = {'-DTDEBUG', '-I' .. vim.fn.expand('~/.local/include')},
    },
    root_dir = function(fname)
        local util = require'lspconfig.util'
        local filename = util.path.is_absolute(fname) and fname or util.path.join(vim.loop.cwd(), fname)
        local root_pattern = util.root_pattern('compile_commands.json', 'compile_flags.txt')

        return root_pattern(filename)
        or root_pattern(vim.loop.cwd())
    end,
    -- cmd = { "clangd", "--clang-tidy" },
}

-- Python
servers.pyright = {
    handlers = {
        ['textDocument/publishDiagnostics'] = function(...) end
    }
}

-- Rust
-- servers.rust_analyzer = {
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
-- servers.gopls = {
--     capabilities = capabilities,
--     root_dir = function(fname)
--         local root_pattern = util.root_pattern('go.mod', '.git')

--         return root_pattern(fname)
--         or root_pattern(vim.fn.getcwd())
--         or util.path.dirname(fname)
--     end
-- }

-- JavaScript/TypeScript
servers.ts_ls = {
    handlers = {
        ['textDocument/publishDiagnostics'] = function(id, result, ctx, config)
            -- Diagnostics codes to ignore
            local ignore_codes = {
                [80001] = true
            }

            result.diagnostics = vim.tbl_filter(function(diag)
                return not ignore_codes[diag.code]
            end, result.diagnostics)

            -- -- Add diagnostic's code to the message
            -- for _, d in ipairs(result.diagnostics) do
            --     d.message = string.format("%s (%d)", d.message, d.code)
            -- end

            return vim.lsp.handlers["textDocument/publishDiagnostics"](id, result, ctx, config)
        end
    }
}

local function main()
    local capabilities = require'cmp_nvim_lsp'.default_capabilities()
    local is_executable = require'util'.is_executable

    for name, opts in pairs(servers) do
        local server = require'lspconfig'[name]
        local cmd = opts.cmd or server.document_config.default_config.cmd

        opts.capabilities = opts.capabilities
            and vim.tbl_extend('keep', opts.capabilities, capabilities)
            or  capabilities

        if is_executable(cmd[1]) then
            server.setup(opts)
        end
    end

    -- I don't like virtual text when showing diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            -- underline = false,
        })

    -- require'lsp_signature'.setup{
    --         hint_enable = false,
    --         toggle_key = '<C-k>',
    --     }
end

return {
    'neovim/nvim-lspconfig',
    config = main,

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        -- 'ray-x/lsp_signature.nvim',
    }
}
