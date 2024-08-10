require('plantuml').setup(
    {
        renderer = {
            type = 'text',
            options = {
                split_cmd = 'vsp', -- Allowed values: 'split', 'vsplit'.
            }
        },
        render_on_write = true, -- Set to false to disable auto-rendering.
    }

)
