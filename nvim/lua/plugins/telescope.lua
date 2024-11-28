return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim',
        'nvim-telescope/telescope-smart-history.nvim',
        'kkharji/sqlite.lua',
    },
    keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end, mode = 'n', desc = "description of the keymap group" },
        { '<leader>gg', function() require('telescope.builtin').git_files() end,  mode = 'n' },
        { '<leader>re', function() require('telescope.builtin').resume() end,  mode = 'n' },
        {'z=', function() require('telescope.builtin').spell_suggest() end },
        {'gd', function() require('telescope.builtin').lsp_definitions() end },
        {'<leader>lr', function() require('telescope.builtin').lsp_references() end },
        {'<leader>li', function() require('telescope.builtin').lsp_implementations() end },
        {'<leader>ld', function() require('telescope.builtin').diagnostics() end },
        {"<leader>fg", function() require('telescope').extensions.live_grep_args.live_grep_args() end},
        --https://www.reddit.com/r/neovim/comments/p8wtmn/comment/hx0usg8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        { "<leader>fg", "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", mode='v'},
        {'<leader>vh',function() require('telescope.builtin').help_tags() end},
        {'<leader>fb',function() require('telescope.builtin').current_buffer_fuzzy_find() end},
        {"<leader>fb",
            "\"zy<cmd>exec 'Telescope current_buffer_fuzzy_find default_text=' . escape(@z, ' ')<cr>", mode='v'},
            {'<leader>fo',function() require('telescope.builtin').oldfiles() end},
        {'<leader>sh', function() require('telescope.builtin').search_history() end},
        {'<leader>sq', function() require('telescope.builtin').quickfixhistory() end},
        {'<leader>sk', function() require('telescope.builtin').keymaps() end},
        {'<leader>fq', function() require('telescope.builtin').quickfix() end},
        {'<leader>og', function() require('telescope.builtin').lsp_outgoing_calls() end  },
        {'<leader>ig', function() require('telescope.builtin').lsp_incoming_calls() end },
        -- open file_browser with the path of the current buffer
        {"<leader>bf", ":Telescope file_browser path=%:p:h select_buffer=true<CR>"},

        -- Alternatively, using lua API
        {"<leader>ba", function()
            require("telescope").extensions.file_browser.file_browser()
        end},
        -- search clipboard history
        { "<leader>hh", ":Telescope neoclip<CR>"}

    },
    config = function()
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    "inv%-dev/.",
                    ".git/",
                    ".venv/"
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
                    '--smart-case',
                    "--glob=!**/.git/*",
                    "--glob=!**/.idea/*",
                    "--glob=!**/.vscode/*",
                    "--glob=!**/build/*",
                    "--glob=!**/dist/*",
                    "--glob=!**/yarn.lock",
                    "--glob=!**/package-lock.json",
                    "--glob=!**/.venv/**",
                    "--glob=!**/venv/**",
                },
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
                    ["<C-h>"] = "which_key",
                    ["<C-j>"] = require('telescope.actions').cycle_history_next,
                    ["<C-k>"] = require('telescope.actions').cycle_history_prev,
                    ["<C-a>"] =  require("trouble.sources.telescope").add,
                    ["<C-l>"] =  require("trouble.sources.telescope").open
                },
                n = {
                    ["<C-j>"] = require('telescope.actions').cycle_history_next,
                    ["<C-k>"] = require('telescope.actions').cycle_history_prev,
                    ["<C-a>"] =  require("trouble.sources.telescope").add,
                    ["<C-l>"] =  require("trouble.sources.telescope").open
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
                        "--glob=!**/.venv/**",
                        "--glob=!**/venv/**",
                    },
                },
            },
        }



        require("telescope").load_extension "file_browser"

        --
        -- vim.builtin.telescope.defaults.preview = { treesitter = false }

        vim.g.telescope_changed_files_base_branch = "master"

        require('telescope').load_extension('smart_history')

    end
}
