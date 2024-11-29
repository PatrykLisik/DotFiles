return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        lazy = true,
        config = false,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')

            cmp.setup({
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'vim-dadbod-completion' },
                    { name = 'buffer' },
                    { name = 'luasnip',                option = { show_autosnippets = true } },
                    { name = "dotenv" },
                    { name = "latex_symbols" },
                    -- {
                    --     name = "cmp_yanky",
                    --     option = {
                    --         -- only suggest items which match the current filetype
                    --         onlyCurrentFiletype = false,
                    --         -- only suggest items with a minimum length
                    --         minLength = 3,
                    --     },
                    -- },
                    { name = "pypi",                   keyword_length = 4 },
                    { name = "go_pkgs" },
                    { name = 'calc' },
                    { name = 'nvim_lua' }
                },
                mapping = cmp.mapping.preset.insert({

                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { "icewind/ltex-client.nvim" },
            { 'hrsh7th/cmp-path' },
            { 'octaltree/cmp-look' },
            { 'hrsh7th/nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'SergioRibera/cmp-dotenv' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-latex-symbols' },
            -- { "chrisgrieser/cmp_yanky" },
            {
                "vrslev/cmp-pypi",
                dependencies = { "nvim-lua/plenary.nvim" },
                ft = "toml",
            },
            { "Snikimonkd/cmp-go-pkgs" },
            { "hrsh7th/cmp-calc" },
            { "hrsh7th/cmp-nvim-lua" },
            {
                'CosmicNvim/cosmic-ui',
                dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
                config = function()
                    require('cosmic-ui').setup()
                end,
            }

        },
        init = function()
            -- Reserve a space in the gutter
            -- This will avoid an annoying layout shift in the screen
            vim.opt.signcolumn = 'yes'
        end,
        config = function()
            local lsp_defaults = require('lspconfig').util.default_config

            -- Add cmp_nvim_lsp capabilities settings to lspconfig
            -- This should be executed before you configure any language server
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
                    -- vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set('n', '<C-Space>', '<cmd>lua require("cosmic-ui").code_actions()<cr>', opts)
                    vim.keymap.set('v', '<C-Space>', '<cmd>lua require("cosmic-ui").code_actions()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua require("cosmic-ui").rename()<cr>', opts)
                end,
            })
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "marksman",
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
                    "bashls",
                    "vacuum",
                    "basedpyright",
                    "ruff"

                }
                -- handlers = {
                --     -- this first function is the "default handler"
                --     -- it applies to every language server without a "custom handler"
                --     function(server_name)
                --         require('lspconfig')[server_name].setup({})
                --     end,
                -- }
            })


            -- These are just examples. Replace them with the language
            -- servers you have installed in your system
            local lsp = require('lsp-zero')
            require 'lspconfig'.jsonls.setup {}
            require 'lspconfig'.yamlls.setup {}
            require 'lspconfig'.bashls.setup {}
            require 'lspconfig'.vacuum.setup {}
            require 'lspconfig'.ltex.setup {
                on_attach = function()
                    lsp.on_attach()
                    os.execute([[docker start languagetool > /dev/null 2>&1 ||  docker run -d \
                    --name languagetool \
                    --restart unless-stopped \
                    --cap-drop ALL \
                    --cap-add CAP_SETUID \
                    --cap-add CAP_SETGID \
                    --cap-add CAP_CHOWN \
                    --security-opt no-new-privileges \
                    --publish 8010:8010 \
                    --env download_ngrams_for_langs=en \
                    --read-only \
                    --tmpfs /tmp \
                    --volume ~/.local/share/nvim/languagetool/ngrams:/ngrams \
                    --volume ~/.local/share/nvim/languagetool/fasttext:/fasttext \
                    meyay/languagetool:latest \
                    > /dev/null 2>&1
                    ]]
                    )
                end,
                settings = {
                    ltex = {
                        language = "pl-PL",
                        languageToolHttpServerUri = 'http://localhost:8081/v2',
                        setenceCacheSize = 2000,
                        additionalRules = {
                            enablePickyRules = true,
                            motherTongue = "pl-PL",
                        }
                    }
                },
                filetypes = { "tex", "bib", "plaintext", "text" }

            }
            require("ltex-client").setup({
                user_dictionaries_path = '/home/plisik/.config/nvim/spell'
            })

            require('lspconfig').texlab.setup {
                on_attach = lsp.on_attach,
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
                            ['local'] = nil, -- local is a reserved keyword
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

            -- Configure `ruff-lsp`.
            -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
            -- For the default config, along with instructions on how to customize the settings
            require('lspconfig').ruff.setup {
                init_options = {
                    settings = {
                        -- Any extra CLI arguments for `ruff` go here.
                        args = {},
                    }
                }
            }

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            require('lspconfig').basedpyright.setup {
                settings = {
                    basedpyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                        typeCheckingMode = 'basic',
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = 'openFilesOnly',
                            inlayHints = {
                                callArgumentNames = true,
                                variableTypes = true
                            }
                        }
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { '*' },

                        },
                    },
                },
            }
        end
    }
}
