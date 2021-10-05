local vim = vim
local cmd = vim.cmd

return require'packer'.startup(function()
    use {
        'wbthomason/packer.nvim',
        opt = true,

        config = [[require'self.plugins']],
        cmd = { 'PackerInstall', 'PackerUpdate', 'PackerSync',
                'PackerClean', 'PackerCompile' }
    }

    use 'lewis6991/impatient.nvim'
    use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
end)
