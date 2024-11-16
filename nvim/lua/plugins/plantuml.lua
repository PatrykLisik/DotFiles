return {
    'https://gitlab.com/itaranto/plantuml.nvim',
    version = '*',
    config = function()
        require('plantuml').setup(
            {
                renderer = {
                    type = 'image',
                    options = {
                        prog = 'nsxiv',
                        dark_mode = false,
                        format = nil, -- Allowed values: nil, 'png', 'svg'.
                        split_cmd = 'vsplit'
                    }
                },
                render_on_write = true,
            }
        )
    end
}
