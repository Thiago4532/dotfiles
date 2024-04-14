local vim = vim
local map = vim.keymap.set

local gpreview = require 'github-preview'
gpreview.setup {}

local fns = gpreview.fns

local function enable_on_single()
    fns.single_file_on()
end

map("n", "<leader>mt", fns.toggle)
map("n", "<F9>", fns.toggle)
map("n", "<leader>ms", fns.single_file_toggle)
map("n", "<leader>md", fns.details_tags_toggle)
