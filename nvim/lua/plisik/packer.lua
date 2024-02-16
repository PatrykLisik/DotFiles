-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = {
            {'nvim-lua/plenary.nvim'},
            { "nvim-telescope/telescope-live-grep-args.nvim" }
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
	}
	use('nvim-treesitter/nvim-treesitter', {run =  ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-context')
	use('nvim-lua/plenary.nvim')
	use('ThePrimeagen/harpoon')
	use('mbbill/undotree')
    use('tpope/vim-fugitive')
    --themes
    use({'rose-pine/neovim', as = 'rose-pine' })
    use {"catppuccin/nvim", as = "catppuccin" }
    use('hrsh7th/cmp-path')
    use('integralist/vim-mypy')
    use("terrortylor/nvim-comment")
    use({
        'CosmicNvim/cosmic-ui',
        requires = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            require('cosmic-ui').setup()
        end,
    })
    use( {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            use({
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!:).
                run = "make install_jsregexp"
            }),     -- Required
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
    --use('uga-rosa/cmp-dictionary')
   -- use("jhofscheier/ltex-utils.nvim")
   use({'jakewvincent/texmagic.nvim',
   config = function()
       require('texmagic').setup({
           -- Config goes here; leave blank for defaults
       })
   end
})
end)
