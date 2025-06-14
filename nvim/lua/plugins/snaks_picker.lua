return {
    "folke/snacks.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {
            size = 3 * 1024 * 1024,
            line_length = 1000
        },
        animate = {},
        quickfile = {},
        explorer = {},
        picker = {
            prompt = " ",
            sources = {
                explorer = {
                    layout = {
                        preset = "default",
                        preview = true
                    },
                    auto_close = true,
                    replace_netrw = true
                },
                marks = {
                    actions = {
                        delmark = function(picker, item)
                            local cursor = picker.list.cursor
                            local select = picker:selected { fallback = true }
                            -- stylua: ignore
                            local delete = vim.iter(select):map(function(it) return it.label end):join ''
                            local ok
                            print(delete)
                            vim.api.nvim_win_call(vim.fn.win_getid(vim.fn.winnr '#'), function()
                                ok = pcall(vim.cmd.delmark, delete)
                                picker:find() -- NOTE: Should also be called inside `nvim_win_cal`
                            end)
                            if ok then
                                for _, it in ipairs(select) do
                                    picker.list:unselect(it)
                                end
                            else
                                Snacks.notify.error(string.format('Unable to delete marks: %s', delete))
                            end
                            picker.list:view(math.min(cursor, #picker.list.items))
                        end,
                    }
                }
            },
            focus = "input",
            layout = {
                cycle = true,
                --- Use the default layout or vertical if the window is too narrow
                preset = function()
                    return vim.o.columns >= 120 and "default" or "vertical"
                end,
            },
            ---@class snacks.picker.matcher.Config
            matcher = {
                fuzzy = true,          -- use fuzzy matching
                smartcase = true,      -- use smartcase
                ignorecase = true,     -- use ignorecase
                sort_empty = false,    -- sort results when the search string is empty
                filename_bonus = true, -- give bonus for matching file names (last part of the path)
                file_pos = true,       -- support patterns like `file:line:col` and `file:line`
                -- the bonusses below, possibly require string concatenation and path normalization,
                -- so this can have a performance impact for large lists and increase memory usage
                cwd_bonus = true,     -- give bonus for matching files in the cwd
                frecency = true,      -- frecency bonus
                history_bonus = true, -- give more weight to chronological order
            },
            sort = {
                fields = { "score:desc", "#text", "idx" },
            },
            ui_select = true, -- replace `vim.ui.select` with the snacks picker
            ---@class snacks.picker.formatters.Config
            formatters = {
                text = {
                    ft = nil, ---@type string? filetype for highlighting
                },
                file = {
                    filename_first = false, -- display filename before the file path
                    truncate = 75,          -- truncate the file path to (roughly) this length
                    filename_only = false,  -- only show the filename
                    icon_width = 2,         -- width of the icon (in characters)
                    git_status_hl = true,   -- use the git status highlight group for the filename
                },
                selected = {
                    show_always = false, -- only show the selected column when there are multiple selections
                    unselected = true,   -- use the unselected icon for unselected items
                },
                severity = {
                    icons = true,  -- show severity icons
                    level = false, -- show severity level
                    ---@type "left"|"right"
                    pos = "left",  -- position of the diagnostics
                },
            },
            ---@class snacks.picker.previewers.Config
            previewers = {
                diff = {
                    builtin = true,    -- use Neovim for previewing diffs (true) or use an external tool (false)
                    cmd = { "delta" }, -- example to show a diff with delta
                },
                git = {
                    builtin = true, -- use Neovim for previewing git output (true) or use git (false)
                    args = {},      -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
                },
                file = {
                    max_size = 5 * 1024 * 1024, -- 5MB
                    max_line_length = 10000,    -- max line length
                    ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
                },
                man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
            },
            ---@class snacks.picker.jump.Config
            jump = {
                jumplist = true,   -- save the current position in the jumplist
                tagstack = false,  -- save the current position in the tagstack
                reuse_win = false, -- reuse an existing window if the buffer is already open
                close = true,      -- close the picker when jumping/editing to a location (defaults to true)
                match = false,     -- jump to the first match position. (useful for `lines`)
            },
            toggles = {
                follow = "f",
                hidden = "h",
                ignored = "i",
                modified = "m",
                regex = { icon = "R", value = false },
            },
            win = {
                -- input window
                input = {
                    keys = {
                        -- to close the picker on ESC instead of going to normal mode,
                        -- add the following keymap to your config
                        -- ["<Esc>"] = { "close", mode = { "n", "i" } },
                        ["/"] = "toggle_focus",
                        ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
                        ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
                        ["<C-c>"] = { "cancel", mode = "i" },
                        ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
                        ["<CR>"] = { "confirm", mode = { "n", "i" } },
                        ["<Down>"] = { "list_down", mode = { "i", "n" } },
                        ["<Esc>"] = "cancel",
                        ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
                        ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
                        ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
                        ["<Up>"] = { "list_up", mode = { "i", "n" } },
                        ["<a-d>"] = { "inspect", mode = { "n", "i" } },
                        ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
                        ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
                        ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
                        ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
                        ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
                        ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
                        ["<c-a>"] = { "select_all", mode = { "n", "i" } },
                        ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
                        ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
                        ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
                        ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
                        ["<c-j>"] = { "list_down", mode = { "i", "n" } },
                        ["<c-k>"] = { "list_up", mode = { "i", "n" } },
                        ["<c-n>"] = { "list_down", mode = { "i", "n" } },
                        ["<c-p>"] = { "list_up", mode = { "i", "n" } },
                        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
                        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
                        ["<c-t>"] = { "tab", mode = { "n", "i" } },
                        ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
                        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
                        ["<c-r>#"] = { "insert_alt", mode = "i" },
                        ["<c-r>%"] = { "insert_filename", mode = "i" },
                        ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
                        ["<c-r><c-f>"] = { "insert_file", mode = "i" },
                        ["<c-r><c-l>"] = { "insert_line", mode = "i" },
                        ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
                        ["<c-r><c-w>"] = { "insert_cword", mode = "i" },
                        ["<c-w>H"] = "layout_left",
                        ["<c-w>J"] = "layout_bottom",
                        ["<c-w>K"] = "layout_top",
                        ["<c-w>L"] = "layout_right",
                        ["?"] = "toggle_help_input",
                        ["G"] = "list_bottom",
                        ["gg"] = "list_top",
                        ["j"] = "list_down",
                        ["k"] = "list_up",
                        ["q"] = "close",
                        ['dd'] = { 'delmark', mode = { 'i', 'n' } }
                    },
                    b = {
                        minipairs_disable = true,
                    },
                },
                -- result list window
                list = {
                    keys = {
                        ["/"] = "toggle_focus",
                        ["<2-LeftMouse>"] = "confirm",
                        ["<CR>"] = "confirm",
                        ["<Down>"] = "list_down",
                        ["<Esc>"] = "cancel",
                        ["<S-CR>"] = { { "pick_win", "jump" } },
                        ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
                        ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
                        ["<Up>"] = "list_up",
                        ["<a-d>"] = "inspect",
                        ["<a-f>"] = "toggle_follow",
                        ["<a-h>"] = "toggle_hidden",
                        ["<a-i>"] = "toggle_ignored",
                        ["<a-m>"] = "toggle_maximize",
                        ["<a-p>"] = "toggle_preview",
                        ["<a-w>"] = "cycle_win",
                        ["<c-a>"] = "select_all",
                        ["<c-b>"] = "preview_scroll_up",
                        ["<c-d>"] = "list_scroll_down",
                        ["<c-f>"] = "preview_scroll_down",
                        ["<c-j>"] = "list_down",
                        ["<c-k>"] = "list_up",
                        ["<c-n>"] = "list_down",
                        ["<c-p>"] = "list_up",
                        ["<c-q>"] = "qflist",
                        ["<c-s>"] = "edit_split",
                        ["<c-t>"] = "tab",
                        ["<c-u>"] = "list_scroll_up",
                        ["<c-v>"] = "edit_vsplit",
                        ["<c-w>H"] = "layout_left",
                        ["<c-w>J"] = "layout_bottom",
                        ["<c-w>K"] = "layout_top",
                        ["<c-w>L"] = "layout_right",
                        ["?"] = "toggle_help_list",
                        ["G"] = "list_bottom",
                        ["gg"] = "list_top",
                        ["i"] = "focus_input",
                        ["j"] = "list_down",
                        ["k"] = "list_up",
                        ["q"] = "close",
                        ["zb"] = "list_scroll_bottom",
                        ["zt"] = "list_scroll_top",
                        ["zz"] = "list_scroll_center",
                    },
                    wo = {
                        conceallevel = 2,
                        concealcursor = "nvc",
                    },
                },
                -- preview window
                preview = {
                    keys = {
                        ["<Esc>"] = "cancel",
                        ["q"] = "close",
                        ["i"] = "focus_input",
                        ["<a-w>"] = "cycle_win",
                    },
                },
            },
            ---@class snacks.picker.icons
            icons = {
                files = {
                    enabled = true, -- show file icons
                    dir = "󰉋 ",
                    dir_open = "󰝰 ",
                    file = "󰈔 "
                },
                keymaps = {
                    nowait = "󰓅 "
                },
                undo = {
                    saved = " ",
                },
                ui = {
                    live       = "󰐰 ",
                    hidden     = "h",
                    ignored    = "i",
                    follow     = "f",
                    selected   = "● ",
                    unselected = "○ ",
                    -- selected = " ",
                },
                git = {
                    enabled   = true, -- show git icons
                    commit    = "󰜘 ", -- used by git log
                    staged    = "●", -- staged changes. always overrides the type icons
                    added     = "",
                    deleted   = "",
                    ignored   = " ",
                    modified  = "○",
                    renamed   = "",
                    unmerged  = " ",
                    untracked = "?",
                },
                diagnostics = {
                    Error = " ",
                    Warn  = " ",
                    Hint  = " ",
                    Info  = " ",
                },
                lsp = {
                    unavailable = "",
                    enabled = " ",
                    disabled = " ",
                    attached = "󰖩 "
                },
                kinds = {
                    Array         = " ",
                    Boolean       = "󰨙 ",
                    Class         = " ",
                    Color         = " ",
                    Control       = " ",
                    Collapsed     = " ",
                    Constant      = "󰏿 ",
                    Constructor   = " ",
                    Copilot       = " ",
                    Enum          = " ",
                    EnumMember    = " ",
                    Event         = " ",
                    Field         = " ",
                    File          = " ",
                    Folder        = " ",
                    Function      = "󰊕 ",
                    Interface     = " ",
                    Key           = " ",
                    Keyword       = " ",
                    Method        = "󰊕 ",
                    Module        = " ",
                    Namespace     = "󰦮 ",
                    Null          = " ",
                    Number        = "󰎠 ",
                    Object        = " ",
                    Operator      = " ",
                    Package       = " ",
                    Property      = " ",
                    Reference     = " ",
                    Snippet       = "󱄽 ",
                    String        = " ",
                    Struct        = "󰆼 ",
                    Text          = " ",
                    TypeParameter = " ",
                    Unit          = " ",
                    Unknown       = " ",
                    Value         = " ",
                    Variable      = "󰀫 ",
                },
            },
            ---@class snacks.picker.db.Config
            db = {
                -- path to the sqlite3 library
                -- If not set, it will try to load the library by name.
                -- On Windows it will download the library from the internet.
                sqlite3_path = "/usr/bin/sqlite3", ---@type string?
            },
            ---@class snacks.picker.debug
            debug = {
                scores = false,   -- show scores in the list
                leaks = false,    -- show when pickers don't get garbage collected
                explorer = false, -- show explorer debug info
                files = false,    -- show file debug info
                grep = false,     -- show file debug info
                proc = false,     -- show proc debug info
                extmarks = false, -- show extmarks errors
            },
        },
    },
    keys = {
        -- Top Pickers & Explorer
        { "<leader>,",  function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>/",  function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        { "<leader>bf", function() Snacks.explorer({ follow_file = true }) end,                 desc = "File Explorer" },
        { "<leader>ba", function() Snacks.explorer({ follow_file = false }) end,                desc = "File Explorer projest base" },
        -- find
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>gg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        -- Grep
        { "<leader>fl", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines",              mode = { "v", "x" } },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>fg", function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>fg", function() Snacks.picker.grep_word() end,                               desc = "Visual selection ",         mode = { "v", "x" } },
        -- search
        { '<leader>s"', function() Snacks.picker.registers() end,                               desc = "Registers" },
        { '<leader>s/', function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sc", function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>sC", function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>e",  function() Snacks.picker.marks({ ["local"] = false }) end,              desc = "Marks" },
        { "<leader>sm", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>re", function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { "<leader>uC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        -- LSP
        { "<leader>ld", function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "<leader>lD", function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        { "<leader>lr", function() Snacks.picker.lsp_references() end,                          nowait = true,                      desc = "References" },
        { "<leader>lI", function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "<leader>ly", function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
