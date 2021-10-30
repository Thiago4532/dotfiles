local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local optexpr = { silent = true, noremap = true, expr = true }

-- Disable Ex-mode
map('n', 'Q', '<Nop>', opts)

-- Toggle nvim-tree 
map('n', '<C-n>', ':NvimTreeToggle<CR>', opts) 

-- Highlight keybindings
map('n', '<F1>', ':TSHighlightCapturesUnderCursor<CR>', opts)
map('n', '<F3>', ':noh<CR>', opts)
map('n', '<F4>', [[
&ic ? ':set noic<CR>:echo "Case-sensitive"<CR>' : ':set ic<CR>:echo "Case-insensitive"<CR>'
]], optexpr)

-- Buffer keybindings
map('n', '<C-h>', ':BufferLineCyclePrev<CR>', opts);
map('n', '<C-l>', ':BufferLineCycleNext<CR>', opts);
map('n', 'H', ':BufferLineMovePrev<CR>', opts)
map('n', 'L', ':BufferLineMoveNext<CR>', opts)

map('n', '<leader>q', ':bdelete<CR>', opts);
map('n', '<leader>QQ', ':bdelete!<CR>', opts);
map('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', opts);
map('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', opts);
map('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', opts);
map('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', opts);
map('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', opts);
map('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', opts);
map('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', opts);
map('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', opts);
map('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', opts);

-- lsp keybindings
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
map('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', '<space>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
map('n', '<space>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
map('n', '<space>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
map('n', '<space>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>e', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
map('n', '[d', ':lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', ':lua vim.lsp.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
map("n", "<space>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
map('n', '<leader>s', ':ClangdSwitchSourceHeader<CR>', opts)

-- telescope keybindings
map('n', '<leader>;', ":lua require('telescope.builtin').buffers()<cr>", opts)
map('n', '<C-p>', ":lua require('telescope.builtin').find_files()<cr>", opts)
map('n', '<leader>g', ":lua require('telescope.builtin').live_grep()<cr>", opts)
map('n', '<leader>h', ":lua require('telescope.builtin').help_tags()<cr>", opts)
map('n', '""', ":lua require('telescope.builtin').registers()<cr>", opts)
map('n', 'gD', ":lua vim.lsp.buf.declaration()<CR>", opts)
map('n', 'gd', ":lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
map('n', '<space>D', ":lua require'telescope.builtin'.lsp_type_definitions()<CR>", opts)
map('n', 'gi', ":lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
map('n', 'gr', ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
map('n', '<space>E', ":lua require'telescope.builtin'.lsp_workspace_diagnostics()<CR>", opts)
map('n', '<space>a', ":lua require'telescope.builtin'.lsp_code_actions()<CR>", opts)

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

-- add j/k to jumplist
map('n', 'j', [[(v:count > 1 ? "m'" . v:count : '') . 'j']], optexpr)
map('n', 'k', [[(v:count > 1 ? "m'" . v:count : '') . 'k']], optexpr)

map('n', 'Y', 'y$', opts)

map('n', '<leader>tw', [[
&wrap ? ':set nowrap<CR>:echo "Wrap disabled!"<CR>' : ':set wrap<CR>:echo "Wrap enabled!"<CR>'
]], optexpr)

-- repeat last search command on replace mode
map('n', '<leader>r', 'q/kyy:q<CR>:%s/<C-r>"', { noremap = true })

map('n', '<F8>', ":DetectIndent<CR>",opts)
