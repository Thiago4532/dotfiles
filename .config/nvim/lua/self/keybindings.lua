local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local optexpr = { silent = true, noremap = true, expr = true }

-- Codeforces template
map('n', 'cpp', 'ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>17zt23gg', opts)

-- Toggle nvim-tree 
map('', '<C-n>', ':NvimTreeToggle<CR>', opts) 

-- Highlight keybindings
map('n', '<F1>', ':TSHighlightCapturesUnderCursor<CR>', opts)
map('n', '<F3>', ':noh<CR>', opts)
map('n', '<F4>', [[
&ic ? ':set noic<CR>:echo "Case-sensitive"<CR>' : ':set ic<CR>:echo "Case-insensitive"<CR>'
]], optexpr)

-- Markdown Preview
map('n', '<F9>', '<plug>MarkdownPreview', {})

-- lsp keybindings
map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
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

-- nabla.nvim keybindings
map('n', '<F5>', ':lua require"nabla".action()<CR>', opts)

map('i', '<C-Space>', "<C-x><C-o>", opts)

-- terminal keybindings
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- utility keybindings
map('n', 'mm', ':exe "normal ".(virtcol("$")/2)."|"<CR>', opts)
map('n', 'gQ', 'i<C-m><Esc>', opts)
map('n', '<leader>tw', [[
&wrap ? ':set nowrap<CR>:echo "Wrap disabled!"<CR>' : ':set wrap<CR>:echo "Wrap enabled!"<CR>'
]], optexpr)
