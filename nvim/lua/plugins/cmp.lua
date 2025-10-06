local lspkind_comparator = function(conf)
    local lsp_types = require("cmp.types").lsp
    return function(entry1, entry2)
        if entry1.source.name ~= "nvim_lsp" then
            if entry2.source.name == "nvim_lsp" then
                return false
            else
                return nil
            end
        end
        local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
        local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
        if kind1 == "Variable" and entry1:get_completion_item().label:match("%w*=") then
            kind1 = "Parameter"
        end
        if kind2 == "Variable" and entry2:get_completion_item().label:match("%w*=") then
            kind2 = "Parameter"
        end

        local priority1 = conf.kind_priority[kind1] or 0
        local priority2 = conf.kind_priority[kind2] or 0
        if priority1 == priority2 then
            return nil
        end
        return priority2 < priority1
    end
end

return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'lukas-reineke/cmp-under-comparator',
        "hrsh7th/cmp-nvim-lsp",
        { "icewind/ltex-client.nvim" },
        { 'hrsh7th/cmp-path' },
        { 'octaltree/cmp-look' },
        { 'hrsh7th/nvim-cmp' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'SergioRibera/cmp-dotenv' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-latex-symbols' },
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'vim-dadbod-completion' },
                { name = 'buffer' },
                { name = 'luasnip',              option = { show_autosnippets = true } },
                { name = "dotenv" },
                { name = "latex_symbols" },
                { name = "pypi",                 keyword_length = 4 },
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
            sorting = {
                comparators = {
                    require "cmp-under-comparator".under,
                    lspkind_comparator({
                        kind_priority = {
                            Parameter = 14,
                            Variable = 13,
                            Field = 11,
                            Property = 11,
                            Constant = 10,
                            Enum = 10,
                            EnumMember = 11,
                            Event = 10,
                            Function = 10,
                            Method = 10,
                            Operator = 10,
                            Reference = 10,
                            Class = 10,
                            Struct = 10,
                            Folder = 8,
                            Color = 5,
                            Module = 5,
                            File = 1,
                            Keyword = 10,
                            Constructor = 1,
                            Interface = 1,
                            Snippet = 0,
                            Text = 1,
                            TypeParameter = 1,
                            Unit = 1,
                            Value = 1,
                        },
                    }),
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                }
            }
        })
    end
}
