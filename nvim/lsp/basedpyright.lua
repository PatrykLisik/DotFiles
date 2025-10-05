return {
    settings = {
        basedpyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
            analysis = {
                typeCheckingMode = 'standard',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
                inlayHints = {
                    callArgumentNames = true,
                    variableTypes = true,
                    functionReturnTypes = true,
                    genericTypes = true
                }
            }
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { '*' },

            },
        },
    },
}
