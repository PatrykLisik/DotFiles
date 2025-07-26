return {
    "mistweaverco/kulala.nvim",
    build = function()
        os.execute('npm install -g @mistweaverco/kulala-ls"')
    end,
    keys = {
        { "<leader>Rs", desc = "Send request" },
        { "<leader>Ra", desc = "Send all requests" },
        { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
        global_keymaps = false,
        global_keymaps_prefix = "<leader>k",
        kulala_keymaps_prefix = "",
    },
}
