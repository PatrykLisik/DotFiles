local util = require 'lspconfig.util'

local texlab_build_status = vim.tbl_add_reverse_lookup {
    Success = 0,
    Error = 1,
    Failure = 2,
    Cancelled = 3,
}

local texlab_forward_status = vim.tbl_add_reverse_lookup {
    Success = 0,
    Error = 1,
    Failure = 2,
    Unconfigured = 3,
}

local function buf_build(bufnr)
    bufnr = util.validate_bufnr(bufnr)
    local texlab_client = util.get_active_client_by_name(bufnr, 'texlab')
    local pos = vim.api.nvim_win_get_cursor(0)
    local params = {
        textDocument = { uri = vim.uri_from_bufnr(bufnr) },
        position = { line = pos[1] - 1, character = pos[2] },
    }
    if texlab_client then
        texlab_client.request('textDocument/build', params, function(err, result)
            if err then
                error(tostring(err))
            end
            print('Build ' .. texlab_build_status[result.status])
        end, bufnr)
    else
        print 'method textDocument/build is not supported by any servers active on the current buffer'
    end
end

local function buf_search(bufnr)
    bufnr = util.validate_bufnr(bufnr)
    local texlab_client = util.get_active_client_by_name(bufnr, 'texlab')
    local pos = vim.api.nvim_win_get_cursor(0)
    local params = {
        textDocument = { uri = vim.uri_from_bufnr(bufnr) },
        position = { line = pos[1] - 1, character = pos[2] },
    }
    if texlab_client then
        texlab_client.request('textDocument/forwardSearch', params, function(err, result)
            if err then
                error(tostring(err))
            end
            print('Search ' .. texlab_forward_status[result.status])
        end, bufnr)
    else
        print 'method textDocument/forwardSearch is not supported by any servers active on the current buffer'
    end
end

