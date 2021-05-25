local uv = vim.loop

local pid = {}
local source_path = debug.getinfo(1, 'S').source:match("@(.*/)")

local function _init_handler(client, result)
    pid[#pid + 1] = client.rpc.handle:get_pid()
end

local function _exit_handler()
    if #pid > 0 then
        uv.spawn('bin/amanda', { 
            args = pid;
            detached = true;
            cwd = source_path .. '../'
        })
    end
end

local function _get_pids()
    return pid
end

local function _setup()
    vim.cmd "autocmd VimLeavePre * lua require'teste'.exit_handler()"
end

return {
    setup = _setup;
    init_handler = _init_handler;
    exit_handler = _exit_handler;
    get_pids = _get_pids;
}
