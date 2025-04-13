return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>rr",
            function() require('refactoring').select_refactor() end,
            mode = { "n", "x" }
        },
        {
            "<leader>rp",
            function() require('refactoring').debug.printf({ below = true }) end
        },
        {
            "<leader>pp",
            function() require('refactoring').debug.print_var() end,
            mode = { "n", "x" }
        },
        {
            "<leader>rc",
            function() require('refactoring').debug.cleanup({}) end
        }
    },
    opts = {
        print_var_statements = {
            python = {
                'print(f"XXX %s {%s=}")'
            }
        }
    }
}
