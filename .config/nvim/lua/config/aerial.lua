local backends = {
    ['_'] = {'treesitter', 'lsp', 'markdown', 'asciidoc', 'man'}
}
local alt_backends = {'lsp', 'markdown', 'asciidoc', 'man'}

for _, ft in ipairs(tm_opts.ts_disabled) do
    backends[ft] = alt_backends
end

require'aerial'.setup({
    backends = backends,

    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end
})

vim.keymap.set('n', ',A', '<cmd>AerialToggle!<CR>')
