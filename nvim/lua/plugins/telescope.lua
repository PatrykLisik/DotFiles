return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'nvim-telescope/telescope-smart-history.nvim',
    'kkharji/sqlite.lua'
},
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    "inv%-dev/.",
                    ".git/",
                    -- "%.env"
                },
                initial_mode = "normal",
                vimgrep_arguments = { 'rg',
                    '--hidden',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case' },
                history = {
                    path = '~/.local/share/nvim/telescope_history2.sqlite3',
                    limit = 100,
                }
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
                    collapse_dirs = true,
                    grouped = true,
                    hidden = {
                        file_browser = true,
                        folder_browser = true }

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
                    ["C-j"] = require('telescope.actions').cycle_history_next,
                    ["C-k"] = require('telescope.actions').cycle_history_prev,

                }
            },
            pickers = {
                find_files = {
                    -- hidden = true,
                    -- needed to exclude some files & dirs from general search
                    -- when not included or specified in .gitignore
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/build/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/yarn.lock",
                        "--glob=!**/package-lock.json",
                    },
                },
            },
        }

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true })
        vim.keymap.set('n', '<leader>gg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>tr', builtin.resume, {})
        vim.keymap.set('n', 'z=', builtin.spell_suggest, { noremap = true })
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true })
        vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { noremap = true })
        vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { noremap = true })
        vim.keymap.set('n', '<leader>ld', builtin.diagnostics, { noremap = true, })

        vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        --https://www.reddit.com/r/neovim/comments/p8wtmn/comment/hx0usg8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        vim.keymap.set("v", "<leader>fg", "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>")
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
        vim.keymap.set("v", "<leader>fb",
            "\"zy<cmd>exec 'Telescope current_buffer_fuzzy_find default_text=' . escape(@z, ' ')<cr>")
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
        vim.keymap.set('n', '<leader>sh', builtin.search_history, {})
        vim.keymap.set('n', '<leader>sq', builtin.quickfixhistory, {})
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, {})
        vim.keymap.set('n', '<leader>re', builtin.registers, {})
        vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})



        vim.keymap.set('n', '<leader>og', builtin.lsp_outgoing_calls, {})
        vim.keymap.set('n', '<leader>ig', builtin.lsp_incoming_calls, {})


        require("telescope").load_extension "file_browser"

        -- open file_browser with the path of the current buffer
        vim.keymap.set("n", "<leader>bf", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

        -- Alternatively, using lua API
        vim.keymap.set("n", "<leader>ba", function()
            require("telescope").extensions.file_browser.file_browser()
        end)
        --
        -- vim.builtin.telescope.defaults.preview = { treesitter = false }

        vim.g.telescope_changed_files_base_branch = "master"
        vim.keymap.set('n', '<leader>cc', ":Easypick changed_files<CR><ESC>", {})

        require('telescope').load_extension('smart_history')

        -- search clipboard history
        vim.keymap.set("n", "<leader>hh", ":Telescope neoclip<CR>")
    end
}
