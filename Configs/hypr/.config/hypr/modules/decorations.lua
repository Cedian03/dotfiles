hl.config({
    general = {
        gaps_in          = 4,
        gaps_out         = 8,

        border_size      = 2,

        col              = {
            active_border   = "rgb(ffffff)",
            inactive_border = "rgb(888888)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },

    decoration = {
        rounding         = 14,
        rounding_power   = 2,

        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur             = {
            enabled  = true,
            size     = 8,
            passes   = 2,

            noise    = 0.12,
            contrast = 1.2,
        },
    },
})
