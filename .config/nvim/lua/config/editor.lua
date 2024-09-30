local o, wo, bo = vim.o, vim.wo, vim.bo

-- TAB -> 4 spaces 
bo.tabstop, o.tabstop = 8, 8
bo.softtabstop, o.softtabstop = 4, 4
bo.shiftwidth, o.shiftwidth = 4, 4
bo.expandtab, o.expandtab = true, true

-- Show line numbers
o.number = true
o.relativenumber = true

-- No ESC delay
o.timeoutlen = 500
o.ttimeout = false
-- o.ttimeoutlen = 0

-- Statusline settings
o.laststatus = 2
o.showmode = false
o.ruler = false

-- Mouse features
o.mouse = ''

-- Disable automatic EOL
o.fixendofline = false

-- Disable cursor shape on Insert Mode
o.guicursor = ''

-- Don't wrap long lines
o.wrap = false

-- Turn on insensitive case
o.ignorecase = true

-- Disable sign column
o.signcolumn = 'no'

-- Hide buffers instead of closing them
o.hidden = true

-- No swap file
o.swapfile = false

-- Lower update time
-- o.updatetime = 2000

-- Persistent undo
bo.undofile, o.undofile = true, true

-- Turn off tabline
o.showtabline = 0

-- Disable intro
o.shortmess = o.shortmess .. 'I'

-- Omnicompletion menu
o.completeopt = 'menu,menuone,noselect'

o.foldmethod = 'marker'
vim.opt.foldopen:remove 'search'

-- Do not ident namespace in C++
o.cino = 'N-s,:0,g0'

-- Split right
o.splitright = true

-- Allow execution of local configuration
o.exrc = true
