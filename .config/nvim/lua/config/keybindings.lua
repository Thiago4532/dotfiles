local vim = vim
local dmap = vim.keymap.set
local mopts   = { silent = true }
local mopts_e = { silent = true, expr = true }

local function map(mode, lhs, rhs, expr)
    local opts = expr and mopts_e or mopts
    dmap(mode, lhs, rhs, opts)
end

-- Disable Ex-mode
map('n', 'Q', '<Nop>')

-- Disable <Space>
dmap('', '<Space>', '<Nop>')

-- Remapping , to global clipboard
dmap('', ',', '"+')

map('n', '<F9>', ':MarkdownPreview<CR>')
map('n', '<F1>', ':Inspect<CR>')
map('n', '<F3>', ':noh<CR>')
map('n', '<F4>', function() 
    if vim.o.ic then
        vim.o.ic = false
        print 'Case-sensitive'
    else
        vim.o.ic = true
        print 'Case-insensitive'
    end
end)

-- lsp keybindings
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
map('n', ',gf', ':lua require"lsp-tree".methods.hover_current_function()<CR>')
map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
map('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<space>rn', ':lua vim.lsp.buf.rename()<CR>')
map('n', '<space>e', ':lua vim.diagnostic.open_float()<CR>')
map('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>')
map('n', ']d', ':lua vim.diagnostic.goto_next()<CR>')
map("n", "<space>F", ":lua vim.lsp.buf.format()<CR>")
map('n', '<space>s', ':ClangdSwitchSourceHeader<CR>')
-- map('n', '<space>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
-- map('n', '<space>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
-- map('n', '<space>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
-- map('n', '<space>q', ':lua vim.diagnostic.setloclist()<CR>')

-- window keybindings
map('n', '<M-h>',           '<C-w>h')
map('n', '<M-j>',           '<C-w>j')
map('n', '<M-k>',           '<C-w>k')
map('n', '<M-l>',           '<C-w>l')
map('n', '<M-H>',           '<C-w>H')
map('n', '<M-J>',           '<C-w>J')
map('n', '<M-K>',           '<C-w>K')
map('n', '<M-L>',           '<C-w>L')
map('n', '<M-Tab>',         '<C-w>w')
map('n', '<M-S-Tab>',       '<C-w>W')
map('n', '<M-s>',           '<C-w>s')
map('n', '<M-v>',           '<C-w>v')
map('n', '<M-=>',           '<C-w>+')
map('n', '<M-->',           '<C-w>-')
map('n', '<M-Backspace>',   '<C-w>=')
map('n', '<M-,>',           '<C-w><')
map('n', '<M-.>',           '<C-w>>')
map('n', '<M-q>',           '<C-w>q')

-- terminal keybindings
map('t', '<Esc>', '<C-\\><C-n>')

-- add j/k to jumplist
map({'n', 'x'}, 'j', function()
    if vim.v.count > 1 then
        return "m'" .. vim.v.count .. 'j'
    else
        return 'j'
    end
end, true)

map({'n', 'x'}, 'k', function()
    if vim.v.count > 1 then
        return "m'" .. vim.v.count .. 'k'
    else
        return 'k'
    end
end, true)

-- why not?
map('n', 'Y', 'y$')

-- Toggle wrap
map('n', '<leader>tw', function()
    if vim.o.wrap then
        vim.o.wrap = false
        print 'Wrap disabled!'
    else
        vim.o.wrap = true
        print 'Wrap enabled!'
    end
end)

-- UndoTree
map('n', 'U', ":UndotreeToggle<CR>")

-- Indent after paste
map('n', '<leader>=', '=`]')

-- repeat last search command on replace mode
dmap('n', '<leader>R', 'q/kyy:q<CR>:%s/<C-r>"')

-- center cursor
map('n', 'zg', require'util'.center_cursor)

-- why is the opposite the default?
dmap('', "`", "'")
dmap('', "'", "`")

-- copy whole file
map('n', 'cpy', ':%y+<CR>')

map('n', '<space>n', 'zon')
map('n', '<space>N', 'zoN')
