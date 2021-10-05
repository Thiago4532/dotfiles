-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/thiagomm/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/thiagomm/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/thiagomm/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/thiagomm/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/thiagomm/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto.pairs"] = {
    config = { "vim.g.AutoPairsOpenBalanceBlacklist = {'{'}" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/auto.pairs"
  },
  ["bufferline.nvim"] = {
    config = { "require'bufferline'.setup{}" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/bufferline.nvim"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  ["haskell-vim"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/haskell-vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  kommentary = {
    config = { "require'config.kommentary'" },
    keys = { { "n", "gc" }, { "x", "gc" }, { "n", "gcc" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/kommentary"
  },
  ["lualine.nvim"] = {
    config = { "require'config.statusline'" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nvim-lspconfig"] = {
    config = { "require'config.lsp'" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeOpen", "NvimTreeToggle" },
    config = { "require'nvim-tree'.setup{}" },
    loaded = false,
    needs_bufread = false,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require'config.treesitter'" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    commands = { "PackerInstall", "PackerUpdate", "PackerSync", "PackerClean", "PackerCompile", "PackerLoad" },
    config = { "require'plugins'" },
    loaded = false,
    needs_bufread = false,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/startuptime.vim"
  },
  ["telescope.nvim"] = {
    config = { "require'config.telescope'" },
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-cpp"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/vim-cpp"
  },
  ["vim-cpp-modern"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/vim-cpp-modern"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/vim-glsl"
  },
  ["vim-lsp-cxx-highlight"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/vim-lsp-cxx-highlight"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-surround"] = {
    keys = { { "n", "ds" }, { "n", "cs" }, { "n", "cS" }, { "n", "ys" }, { "n", "yS" }, { "n", "ys" }, { "n", "yS" }, { "n", "yS" }, { "x", "S" }, { "x", "gS" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/vim-surround"
  },
  vimwiki = {
    loaded = true,
    needs_bufread = true,
    path = "/home/thiagomm/.local/share/nvim/site/pack/packer/opt/vimwiki"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: vim-surround
time([[Setup for vim-surround]], true)
vim.g.surround_no_insert_mappings = 1
time([[Setup for vim-surround]], false)
-- Setup for: vimwiki
time([[Setup for vimwiki]], true)
vim.g.vimwiki_list = {{path = '~/Documents/vimwiki', path_html = '~/Documents/HTML'}}
time([[Setup for vimwiki]], false)
time([[packadd for vimwiki]], true)
vim.cmd [[packadd vimwiki]]
time([[packadd for vimwiki]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require'config.lsp'
time([[Config for nvim-lspconfig]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require'config.statusline'
time([[Config for lualine.nvim]], false)
-- Config for: auto.pairs
time([[Config for auto.pairs]], true)
vim.g.AutoPairsOpenBalanceBlacklist = {'{'}
time([[Config for auto.pairs]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
require'bufferline'.setup{}
time([[Config for bufferline.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require'config.telescope'
time([[Config for telescope.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require'config.treesitter'
time([[Config for nvim-treesitter]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerCompile lua require("packer.load")({'packer.nvim'}, { cmd = "PackerCompile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeOpen lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerLoad lua require("packer.load")({'packer.nvim'}, { cmd = "PackerLoad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerSync lua require("packer.load")({'packer.nvim'}, { cmd = "PackerSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerInstall lua require("packer.load")({'packer.nvim'}, { cmd = "PackerInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerUpdate lua require("packer.load")({'packer.nvim'}, { cmd = "PackerUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerClean lua require("packer.load")({'packer.nvim'}, { cmd = "PackerClean", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> gc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gcc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> S <cmd>lua require("packer.load")({'vim-surround'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cs <cmd>lua require("packer.load")({'vim-surround'}, { keys = "cs", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> cS <cmd>lua require("packer.load")({'vim-surround'}, { keys = "cS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ys <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ys", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> yS <cmd>lua require("packer.load")({'vim-surround'}, { keys = "yS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> yS <cmd>lua require("packer.load")({'vim-surround'}, { keys = "yS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> gS <cmd>lua require("packer.load")({'vim-surround'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ds <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ds", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ys <cmd>lua require("packer.load")({'vim-surround'}, { keys = "ys", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> yS <cmd>lua require("packer.load")({'vim-surround'}, { keys = "yS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[xnoremap <silent> gc <cmd>lua require("packer.load")({'kommentary'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
