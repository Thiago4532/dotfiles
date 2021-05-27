local uv = vim.loop
local api = vim.api

local source_path = debug.getinfo(1, 'S').source:match("@(.*/)")

local function err_message(...)
  api.nvim_err_writeln(table.concat(vim.tbl_flatten{...}))
end

return {
    assert = function()
        if not vim.lsp._thiago_ then
            err_message("Couldn't load modified vim.lsp!")
        end
    end,
    _call_exit = function(pid_list)
        if #pid_list > 0 then
            uv.spawn('bin/amanda', { 
                args = pid_list;
                detached = true;
                cwd = source_path .. '../'
            })
        end
    end
}
