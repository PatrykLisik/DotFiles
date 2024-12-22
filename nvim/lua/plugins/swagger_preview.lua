return {
    "vinnymeller/swagger-preview.nvim",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    build = "npm install swagger-ui-watcher -g",
    config = function()
        require("swagger-preview").setup({
            -- The port to run the preview server on
            port = 8000,
            -- The host to run the preview server on
            host = "localhost",
        })
    end
}
