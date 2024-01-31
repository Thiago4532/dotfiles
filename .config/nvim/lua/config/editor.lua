local o, wo, bo = vim.o, vim.wo, vim.bo

-- TAB -> 4 spaces 
bo.tabstop, o.tabstop = 8, 8
bo.softtabstop, o.softtabstop = 4, 4
bo.shiftwidth, o.shiftwidth = 4, 4
bo.expandtab, o.expandtab = true, true

-- Show line numbers
wo.number, o.number = true, true
wo.relativenumber, o.relativenumber = true, true

-- No ESC delay
o.timeoutlen = 500
o.ttimeoutlen = 0

-- Statusline settings
o.laststatus = 2
o.showmode = false
o.ruler = false

-- Mouse features
o.mouse = ''

-- Disable automatic EOL
o.fixendofline, bo.fixendofline = false, false

-- Disable cursor shape on Insert Mode
o.guicursor = ''

-- Don't wrap long lines
wo.wrap, o.wrap = false, false

-- Turn on insensitive case
o.ignorecase = true

-- Disable sign column
wo.signcolumn, o.signcolumn = 'no', 'no'

-- Hide buffers instead of closing them
o.hidden = true

-- No swap file
bo.swapfile, o.swapfile = false, false

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

-- Do not ident namespace in C++
o.cino = 'N-s,:0,g0'

-- Split right
o.splitright = true
