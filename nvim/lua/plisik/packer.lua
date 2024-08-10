-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                            , branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            { 'nvim-telescope/telescope-fzf-native.nvim',    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "axkirillov/easypick.nvim" }
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
            require('telescope').load_extension('fzf')
        end
    }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-lua/plenary.nvim')
    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use { "catppuccin/nvim", as = "catppuccin" }
    use('hrsh7th/cmp-path')
    use('octaltree/cmp-look')
    use("terrortylor/nvim-comment")
    use({
        'CosmicNvim/cosmic-ui',
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require('cosmic-ui').setup()
        end,
    })
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            use({
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!:).
                run = "make install_jsregexp"
            }), -- Required
            use { 'saadparwaiz1/cmp_luasnip' }
        }
    })
    use({
        "nvim-tree/nvim-tree.lua",
        after = "nvim-web-devicons",
        requires = "nvim-tree/nvim-web-devicons",
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use('vigoux/LanguageTool.nvim')
    use('simrat39/inlay-hints.nvim')
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use("icewind/ltex-client.nvim")
    use("ThePrimeagen/vim-be-good")
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use {'javiorfo/nvim-soil', requires = 'javiorfo/nvim-nyctophilia' } -- puml
    use { "sindrets/diffview.nvim" }

    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    use('mfussenegger/nvim-dap')
    use {
        'linrongbin16/lsp-progress.nvim',
        config = function()
          require('lsp-progress').setup()
        end
      }
    use {"kdheepak/lazygit.nvim"}

    use {
        'https://gitlab.com/itaranto/plantuml.nvim',
        tag = '*',
        config = function() require('plantuml').setup() end
    }
    --use('uga-rosa/cmp-dictionary')
    -- use({
    --     'jakewvincent/texmagic.nvim',
    --     config = function()
    --         require('texmagic').setup({
    --             -- Config goes here; leave blank for defaults
    --         })
    --     end
    -- })
    -- use({
    --     "stevearc/oil.nvim",
    --     config = function()
    --         require("oil").setup()
    --     end,
    -- })
end)
