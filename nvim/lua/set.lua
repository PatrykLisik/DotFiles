vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.api.nvim_create_user_command("Spell", "setlocal spell! spelllang=en,pl", { desc = "Toggle spelling" })
vim.cmd("setlocal spell spelllang=en,pl")

vim.cmd.syntax 'off'

vim.env.PATH          = "/snap/bin/npm:" .. vim.env.PATH

vim.g.netrw_preview   = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize   = 30

vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.tex,*.bib",
        callback = function()
            local buf = vim.api.nvim_get_current_buf()
            vim.bo[buf].filetype = "latex"
        end
    }
)

vim.api.nvim_create_autocmd("BufRead", {
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "quickfix" then
            vim.schedule(function()
                vim.cmd([[cclose]])
                vim.cmd([[Trouble qflist open]])
            end)
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if vim.tbl_contains({ 'null-ls' }, client.name) then -- blacklist lsp
            return
        end
        require("lsp_signature").on_attach({
            bind = true,
            floating_window = false,
            hint_inline = function() return false end,
            toggle_key = '<C-p>',
            select_signature_key = '<C-s>',
            hint_prefix = {
                above = "↙ ", -- when the hint is on the line above the current line
                current = "← ", -- when the hint is on the same line
                below = "↖ " -- when the hint is on the line below the current line
            }
        }, bufnr)
    end,
})


vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function(ev)
        if vim.bo[ev.buf].filetype == "gitcommit" then
            vim.cmd([[setlocal spell! spelllang=en,pl]])
        end
    end,
})

vim.api.nvim_create_autocmd({"BufWinEnter","BufEnter","FocusGained","InsertLeave"}, {
    callback = function(ev)
        vim.cmd([[set relativenumber]])
    end,
})

vim.api.nvim_create_autocmd({"BufLeave","FocusLost","InsertEnter"}, {
    callback = function(ev)
        vim.cmd([[set norelativenumber]])
    end,
})
