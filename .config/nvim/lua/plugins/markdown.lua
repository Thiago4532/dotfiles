local map = vim.keymap.set
local is_executable = require'util'.is_executable

local M = {}

-- plugin: markdown-preview.nvim
do
    M[#M + 1] = {
        'iamcco/markdown-preview.nvim',
        enabled = is_executable'yarn',

        -- cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        -- keys = { { '<F9>' } },
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' }
    }
end

-- plugin: render-markdown.nvim
do
    local file_types = {'markdown', 'Avante'}

    M[#M + 1] = {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            file_types = file_types
        },
        ft = file_types
    }
end

-- plugin: markview.nvim
-- do
--     M[#M + 1] = {
--         "OXY2DEV/markview.nvim",

--         dependencies = {
--             "nvim-treesitter/nvim-treesitter",
--             "nvim-tree/nvim-web-devicons"
--         }
--     }
-- end

return M
