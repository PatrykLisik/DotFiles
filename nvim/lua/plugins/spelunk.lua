return {
    'EvWilson/spelunk.nvim',
    dependencies = {
        'folke/snacks.nvim',                   -- Optional: for enhanced fuzzy search capabilities
        'nvim-treesitter/nvim-treesitter',     -- Optional: for showing grammar context
        'nvim-lualine/lualine.nvim',           -- Optional: for statusline display integration
    },
    config = function()
        require('spelunk').setup({
            enable_persist = true,
            enable_status_col_display = true,
            persist_by_git_branch = true,
            fuzzy_search_provider = 'snacks',
            base_mappings = {
                -- Toggle the UI open/closed
                toggle = '<leader>e',
                -- Add a bookmark to the current stack
                add = '<leader>ba',
                -- Delete current line's bookmark from the current stack
                delete = '<leader>bd',
                -- Move to the next bookmark in the stack
                next_bookmark = '<leader>bn',
                -- Move to the previous bookmark in the stack
                prev_bookmark = '<leader>bp',
                -- Fuzzy-find all bookmarks
                search_bookmarks = '<leader>bb',
                -- Fuzzy-find bookmarks in current stack
                search_current_bookmarks = '<leader>bc',
                -- Fuzzy find all stacks
                search_stacks = '<leader>bs',
                -- Change line of hovered bookmark
                change_line = "<leader>bl",
            }
        })
    end
}
