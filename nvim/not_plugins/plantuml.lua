require('plantuml').setup(
    {
        renderer = {
            type = 'image',
            options = {
                prog = 'nsxiv -b',
                dark_mode = false,
                format = nil, -- Allowed values: nil, 'png', 'svg'.
            }
        },
        render_on_write = true,
    }

)
