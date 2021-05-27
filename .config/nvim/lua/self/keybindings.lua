local map = vim.api.nvim_set_keymap
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

local opts = { noremap = true, silent = true }

-- Codeforces template
map('n', 'cpp', 'ggdG:-1read ~/CP-Problems/Codeforces/base.cpp<CR>17zt23gg', opts)

-- Toggle nvim-tree 
map('', '<C-n>', ':NvimTreeToggle<CR>', opts) 

-- Move line up/down
map('n', '<C-k>', ':m-2<CR>', opts)
map('n', '<C-j>', ':m+<CR>',  opts)

-- Highlight keybindings
map('n', '<F1>', ':call PrintHighlightGroup()<CR>', opts)
map('n', '<F3>', ':noh<CR>', opts)
map('n', '<F4>', ':set ic<CR>:echo "Case-insensitive"<CR>', opts)
map('n', '<F5>', ':set noic<CR>:echo "Case-sensitive"<CR>', opts)

-- Markdown Preview
map('n', '<F9>', '<plug>MarkdownPreview', {})

-- macro keybindings
--[[ map('n', '<leader>ro', ':enew<CR>:setlocal binary noeol buftype=nofile<CR>"rpggJ', opts)
map('n', '<leader>rs', '^"rd$:bd<CR>', opts) ]]

-- lsp keybindings
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- telescope keybindings
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
