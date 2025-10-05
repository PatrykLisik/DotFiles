vim.lsp.config("ltex", {
    filetypes = { "tex", "latex", "bib", "plaintext", "text" },
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

})
