local lsp = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local ih = require("inlay-hints")
lsp.preset({})

--https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#setup

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    -- print(client.config.name .. " starting...")
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<C-Space>', '<cmd>lua require("cosmic-ui").code_actions()<cr>', opts)
    buf_set_keymap('v', '<C-Space>', '<cmd>lua require("cosmic-ui").code_actions()<cr>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua require("cosmic-ui").rename()<cr>', opts)
    -- buf_set_keymap('v', '<C-c>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end)
-- Use Enter to confirm completion
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    })
})
--Preselect first item
cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    })
})

-- lua snippets lsp setup
cmp.setup({
    snippet = {
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'path' },
        {
            name = 'look',
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true,
                dict = '/home/plisik/.config/nvim/spell/en.dict'
            }
        }
        -- {
        --     name = 'spell',
        --     option = {
        --         keep_all_entries = false,
        --         enable_in_context = function()
        --             return true
        --         end,
        --     },
        -- },
    },
    mapping = {
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})


lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    "marksman",
    "pylsp",
    "gopls",
    "texlab",
    "lua_ls",
    "jdtls",
    -- "vale_ls",
    "docker_compose_language_service",
    "dockerls",
    "typos_lsp",
    "ltex",
    "jsonls",
    "yamlls",
    "jinja_lsp",
    "bashls",
    "vacuum",

})


-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require('lspconfig').pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                black = {
                    enabled = true,
                    line_length = 140
                },
                jedi = {
                    auto_import_modules = { "numpy", "datetime", "json", "sqlalchemy" }
                },
                jedi_rename = {
                    enabled = true
                },
                jedi_completion = {
                    eager = true,
                    fuzzy = true

                },
                rope_autoimport = {
                    enabled = true,
                    memory = true,
                    completions = {
                        enabled = false
                    }
                },
                -- rope_rename = {
                --     enabled = false

                -- },
                flake8 = {
                    extendignore = { "W503", "E501" }
                },
                pycodestyle = {
                    enabled = false,
                    ignore = { 'E501', 'E231' },
                    maxLineLength = 140 },
                yapf = { enabled = true },
                -- https://github.com/python-lsp/python-lsp-ruff?tab=readme-ov-file#configuration
                ruff = {
                    enabled = true,          -- Enable the plugin
                    formatEnabled = true,    -- Enable formatting using ruffs formatter
                    -- executable = "<path-to-ruff-bin>", -- Custom path to ruff
                    -- config = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
                    extendSelect = { "I" },  -- Rules that are additionally used by ruff
                    extendIgnore = { "C90","W503", "E501" }, -- Rules that are additionally ignored by ruff
                    format = { "I" },        -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
                    severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
                    unsafeFixes = false,     -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

                    -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
                    lineLength = 140,                   -- Line length to pass to ruff checking and formatting
                    exclude = { "__about__.py" },      -- Files to be excluded by ruff checking
                    select = { "F" },                  -- Rules to be enabled by ruff
                    ignore = { "D210" },               -- Rules to be ignored by ruff
                    perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
                    preview = true,                   -- Whether to enable the preview style linting and formatting.
                    targetVersion = "py310",           -- The minimum python version to target (applies for both linting and formatting).
                },
            }
        }
    }
}


local util = require 'lspconfig.util'
require('lspconfig').gopls.setup {
    on_attach = function(c, b)
        lsp.on_attach(c, b)
    end,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = false,
            gofumpt = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
    root_dir = function(fname)
        -- see: https://github.com/neovim/nvim-lspconfig/issues/804
        local mod_cache = vim.trim(vim.fn.system 'go env GOMODCACHE')
        if fname:sub(1, #mod_cache) == mod_cache then
            local clients = vim.lsp.get_active_clients { name = 'gopls' }
            if #clients > 0 then
                return clients[#clients].config.root_dir
            end
        end
        return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
    end,
}


require('lspconfig').texlab.setup {
    on_attach = lsp.on_attach,
    capabilities = lsp_capabilities,
    cmd = { "texlab" },
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-shell-escape', '-pv', '-f', '-output-directory=./pdf/', '-interaction=nonstopmode', '-synctex=1', '%f' },
                pdfDirectory = "./pdf/",
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                onSave = true
            },
            auxDirectory = './aux',
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil,         -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 120,
        },
    },
}

require("lspconfig").jdtls.setup {}

-- require("lspconfig").vale_ls.setup{
--     filetypes={ "markdown", "text","tex" },
-- }

require("lspconfig").docker_compose_language_service.setup {
    -- on_attach=lsp.on_attach,
    filetypes = { "yml", "yaml" },
    -- root_pattern={"docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"},
    -- cmd={ "docker-compose-langserver", "--stdio" },
    -- single_file_support=true
}

require("lspconfig").dockerls.setup {
    filetypes = { "Dockerfile" }
}

require('lspconfig').typos_lsp.setup({
    filetypes = { "lua", "go", "python", "yaml", "java", "sql" },
    -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
    cmd_env = { RUST_LOG = "error" },
    init_options = {
        -- Custom config. Used together with any workspace config files, taking precedence for
        -- settings declared in both. Equivalent to the typos `--config` cli argument.
        config = '~/.config/typos_lsp/typos.toml',
        -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
        -- Defaults to error.
        diagnosticSeverity = "Warning"
    }
})

require'lspconfig'.jsonls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.jinja_lsp.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.vacuum.setup{}
require'lspconfig'.ltex.setup{
    on_attach = lsp.on_attach,
    settings ={
        ltex = {
            language = "pl-PL",
           languageToolHttpServerUri='http://localhost:8081/v2',
            setenceCacheSize = 2000,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "pl-Pl",
            }
        }
    }
}
require("ltex-client").setup({
    user_dictionaries_path = '/home/plisik/.config/nvim/spell'
})
lsp.setup()
