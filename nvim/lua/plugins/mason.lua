return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
        automatic_enable = true,
        ensure_installed = {
            "marksman",
            "gopls",
            "texlab",
            "lua_ls",
            "jdtls",
            "vale_ls",
            "docker_compose_language_service",
            "dockerls",
            "typos_lsp",
            "ltex",
            "jsonls",
            "yamlls",
            "bashls",
            "vacuum",
            "basedpyright",
            "ruff",
            "rust_analyzer",
        }
    }

}
