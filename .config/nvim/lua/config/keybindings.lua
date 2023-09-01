local map = vim.keymap.set
local opts = { silent = true }
local optexpr = { silent = true, expr = true }

-- Disable Ex-mode
map('n', 'Q', '<Nop>', opts)

-- Toggle nvim-tree 
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts) 

-- Highlight keybindings
map('n', '<F1>', ':Inspect<CR>', opts) map('n', '<F3>', ':noh<CR>', opts)
map('n', '<F4>', [[
&ic ? ':set noic<CR>:echo "Case-sensitive"<CR>' : ':set ic<CR>:echo "Case-insensitive"<CR>'
]], optexpr)

-- Buffer keybindings
map('n', 'H', ':bp<CR>', opts)
map('n', 'L', ':bl<CR>', opts)
map('n', '<leader>q', ':Bdelete<CR>', opts);
map('n', '<leader>QQ', ':Bdelete!<CR>', opts);

-- lsp keybindings
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', ',gf', ':lua require"lsp-tree".methods.hover_current_function()<CR>', opts)
map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
map('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>e', ':lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', opts)
map("n", "<space>F", ":lua vim.lsp.buf.formatting()<CR>", opts)
map('n', '<space>s', ':ClangdSwitchSourceHeader<CR>', opts)
-- map('n', '<space>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- map('n', '<space>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- map('n', '<space>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- map('n', '<space>q', ':lua vim.diagnostic.setloclist()<CR>', opts)


-- window keybindings
map('n', '<M-h>',           '<C-w>h', opts)
map('n', '<M-j>',           '<C-w>j', opts)
map('n', '<M-k>',           '<C-w>k', opts)
map('n', '<M-l>',           '<C-w>l', opts)
map('n', '<M-H>',           '<C-w>H', opts)
map('n', '<M-J>',           '<C-w>J', opts)
map('n', '<M-K>',           '<C-w>K', opts)
map('n', '<M-L>',           '<C-w>L', opts)
map('n', '<M-Tab>',         '<C-w>w', opts)
map('n', '<M-S-Tab>',       '<C-w>W', opts)
map('n', '<M-s>',           '<C-w>s', opts)
map('n', '<M-v>',           '<C-w>v', opts)
map('n', '<M-=>',           '<C-w>+', opts)
map('n', '<M-->',           '<C-w>-', opts)
map('n', '<M-Backspace>',   '<C-w>=', opts)
map('n', '<M-,>',           '<C-w><', opts)
map('n', '<M-.>',           '<C-w>>', opts)
map('n', '<M-q>',           '<C-w>q', opts)

-- terminal keybindings
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- add j/k to jumplist
map('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], optexpr)
map('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], optexpr)

-- why not?
map('n', 'Y', 'y$', opts)

-- Toggle wrap
map('n', '<leader>tw', [[
&wrap ? ':set nowrap<CR>:echo "Wrap disabled!"<CR>' : ':set wrap<CR>:echo "Wrap enabled!"<CR>'
]], optexpr)

-- UndoTree
map('n', 'U', ":UndotreeToggle<CR>", opts)

-- Indent after paste
map('n', '<leader>=', '=`]', opts)

-- repeat last search command on replace mode
map('n', '<leader>R', 'q/kyy:q<CR>:%s/<C-r>"', { noremap = true })

-- center cursor
map('n', 'zg', ":lua require'util'.center_cursor()<CR>", opts)

map('n', '<F9>', ":MarkdownPreview<CR>", opts)

