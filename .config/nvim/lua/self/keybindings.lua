local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local optexpr = { silent = true, noremap = true, expr = true }

-- Toggle nvim-tree 
map('', '<C-n>', ':NvimTreeToggle<CR>', opts) 

-- Highlight keybindings
map('n', '<F1>', ':TSHighlightCapturesUnderCursor<CR>', opts)
map('n', '<F3>', ':noh<CR>', opts)
map('n', '<F4>', [[
&ic ? ':set noic<CR>:echo "Case-sensitive"<CR>' : ':set ic<CR>:echo "Case-insensitive"<CR>'
]], optexpr)

-- Buffer keybindings
map('n', '<Left>', ':bp<CR>', opts);
map('n', '<Right>', ':bn<CR>', opts);
map('n', '<leader>bd', ':bd<CR>', opts);

map('n', '<leader>1', ':b1<CR>', opts);
map('n', '<leader>2', ':b2<CR>', opts);
map('n', '<leader>3', ':b3<CR>', opts);
map('n', '<leader>4', ':b4<CR>', opts);
map('n', '<leader>5', ':b5<CR>', opts);
map('n', '<leader>6', ':b6<CR>', opts);
map('n', '<leader>7', ':b7<CR>', opts);
map('n', '<leader>8', ':b8<CR>', opts);
map('n', '<leader>9', ':b9<CR>', opts);

-- lsp keybindings
map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
map('i', '<C-k>', '<C-o>:lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>D', ':lua vim.lsp.buf.type_definition()<CR>', opts)
map('n', '<space>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
map('n', '<space>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map("n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>", opts)

-- telescope keybindings
map('n', '<leader>;', ":lua require('telescope.builtin').buffers()<cr>", opts)
map('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<cr>", opts)
map('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<cr>", opts)
map('n', '<leader>fh', ":lua require('telescope.builtin').help_tags()<cr>", opts)

map('i', '<C-Space>', "<C-x><C-o>", opts)

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

-- utility keybindings

-- add j/k to jumplist
map('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], optexpr)
map('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], optexpr)

map('n', 'Y', 'y$', opts)
map('n', 'gQ', 'i<C-m><Esc>', opts)
map('n', '<leader>tw', [[
&wrap ? ':set nowrap<CR>:echo "Wrap disabled!"<CR>' : ':set wrap<CR>:echo "Wrap enabled!"<CR>'
]], optexpr)

map('n', '<F8>', ":DetectIndent<CR>",opts)
