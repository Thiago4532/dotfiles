local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

-- disable providers
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.zig_fmt_autosave = 0
g.mapleader = ','
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1

tm_opts = {}

require'lazy'.setup {
    spec = {
        { import = 'plugins' },
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
}

require 'buf-config'.setup()

-- post-plugin configuration

UU = require'util'
require 'impl.ftdetect'

require 'config.editor'
require 'config.keybindings'

cmd[[
runtime vimscript/ui.vim
runtime vimscript/autocmd.vim
runtime vimscript/commands.vim
]]

require 'impl.bad-habits'

function printi(...)
    vim.print(...)
    -- local tbl = vim.tbl_map(vim.inspect, {...})
    -- local n = select('#', ...)

    -- print(unpack(tbl, 1, n))
end
