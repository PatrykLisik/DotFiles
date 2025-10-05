return {
    filetypes = { "lua", "go", "python", "yaml", "java", "sql" },
    -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
    cmd_env = { RUST_LOG = "error" },
    init_options = {
        -- Custom config. Used together with any workspace config files, taking precedence for
        -- settings declared in both. Equivalent to the typos `--config` cli argument.
        config = '~/.config/typos_lsp/typos.toml',
        -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
        -- Defaults to error.
        diagnosticSeverity = "Warning"
    }
}
