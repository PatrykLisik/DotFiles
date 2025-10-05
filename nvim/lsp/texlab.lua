return {
    cmd = { "texlab" },
    filetypes = { "tex", "latex" },
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-shell-escape', '-pv', '-f', '-output-directory=./pdf/', '-interaction=nonstopmode', '-synctex=1', '%f' },
                pdfDirectory = "./pdf/",
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
                onSave = true
            },
            auxDirectory = './aux',
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 120,
        },
    },
}
