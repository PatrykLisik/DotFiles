return {
    "radyz/telescope-gitsigns",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = {

        {'<leader>hl', function() require('telescope').extensions.git_signs.git_signs() end},
    },
    opts= function()
        require("telescope").load_extension("git_signs")
        return {}
    end

}
