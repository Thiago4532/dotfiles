local vim = vim
local a = require 'plenary.async'
local uv = vim.loop
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local M = {}

local schedule = a.wrap(vim.schedule, 1)
local read_file = function(path)
    assert(type(path) == 'string', 'path must be a string')

    local err, fd = a.uv.fs_open(path, 'r', 438)
    assert(not err, err)

    local err, stat = a.uv.fs_fstat(fd)
    assert(not err, err)

    local err, data = a.uv.fs_read(fd, stat.size, 0)
    assert(not err, err)

    local err = a.uv.fs_close(fd)
    assert(not err, err)

    return data
end

local __cptemplate = nil
local function get_directory()
    if __cptemplate then
        return __cptemplate
    end

    local dirname = vim.env.CP_TEMPLATE_DIR
    assert(dirname, 'CP Template directory is not specified')
    __cptemplate = dirname
    return dirname
end

local template_picker = a.wrap(function(callback)
    local dirpath = get_directory()

    local find_command = {
        'find', dirpath,
        '-type', 'f',
        '-name', '*.cpp',
        '-not', '-path', '*examples*'
    }
    local opts = opts or {}

    opts.entry_maker = function(entry)
        local display = entry:gsub('^.*/(.*)%.cpp$', '%1')
        display = display:gsub('(.)([A-Z])', '%1 %2')
        return {
            value = entry,
            display = display,
            ordinal = display,
        }
    end

    pickers.new(opts, {
        prompt_title = "CPTL",
        __locations_input = true,
        finder = finders.new_oneshot_job(find_command, opts),
        previewer = conf.grep_previewer(opts),
        sorter = conf.file_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                callback(selection.value, selection.display)
            end)
            return true
        end,
    }):find()
end, 1)

local function load()
    local filename, name = template_picker()
    local contents = read_file(filename)
    schedule()
    vim.fn.setreg('', contents)
    print('CPTL: ' .. name)
end

M.load = a.void(load)

return M
