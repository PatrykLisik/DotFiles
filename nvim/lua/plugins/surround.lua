return {
    "tpope/vim-surround",
    lazy = false,
    keys = {
        { "(",  "S)", mode = { "v" }, remap = true },
        { ")",  "S)", mode = { "v" }, remap = true },
        { "[",  "S]", mode = { "v" }, remap = true },
        { "]",  "S]", mode = { "v" }, remap = true },
        -- { "{",  "S}", mode = { "v" }, remap = true },
        -- { "}",  "S}", mode = { "v" }, remap = true },
        { '"',  'S"', mode = { "v" }, remap = true },
        { "'",  "S'", mode = { "v" }, remap = true },

        { "Sb", "S)", mode = { "v" }, remap = true },
        { "Sc", "S{", mode = { "v" }, remap = true },
        { "Ss", "S]", mode = { "v" }, remap = true },
    }
}
