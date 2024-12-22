return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { 'letieu/harpoon-lualine', { "nvim-lua/plenary.nvim" } },
    keys = function()
        local harpoon = require("harpoon")
        return {
            { "<leader>a", function() harpoon:list():add() end },
            { "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
            { "<leader>1",     function() harpoon:list():select(1) end },
            { "<leader>2",     function() harpoon:list():select(2) end },
            { "<leader>3",     function() harpoon:list():select(3) end },
            { "<leader>4",     function() harpoon:list():select(4) end },
            { "<leader>5",     function() harpoon:list():select(5) end }
        }
    end,
    opts = {}
}
