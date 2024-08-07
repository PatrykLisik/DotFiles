require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "inv%-dev/.",
            ".git/",
            "%.env"
        },

    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        file_browser = {
            hijack_netrw = true,
            follow_symlinks = true,
            cwd_to_path = true,
            auto_depth = true,
            collapse_dirs = true

        }
    },
    mappings = {
        i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key"
        },
        n = {
            ["C-j"]  = require('telescope.actions').cycle_history_next,
            ["C-k"]  = require('telescope.actions').cycle_history_prev,

        }
    }
}

local builtin = require('telescope.builtin')


vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
--https://www.reddit.com/r/neovim/comments/p8wtmn/comment/hx0usg8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.keymap.set("v", "<leader>fg", "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>")
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})

require("telescope").load_extension "file_browser"

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>bf", ":Telescope file_browser path=%:p:h select_buffer=true<CR><ESC>")

-- Alternatively, using lua API
vim.keymap.set("n", "<space>ba", function()
    require("telescope").extensions.file_browser.file_browser()
end)
--
-- vim.builtin.telescope.defaults.preview = { treesitter = false }

vim.g.telescope_changed_files_base_branch = "master"
vim.keymap.set('n', '<leader>cc', ":Easypick changed_files<CR>", {})
