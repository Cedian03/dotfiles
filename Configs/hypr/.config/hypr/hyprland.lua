-- https://wiki.hypr.land/Configuring/

mainMod = "SUPER"
terminal = "alacritty"
appLauncher = "pkill rofi || rofi -show drun"
fileManager = "nautilus"
powerMenu = "pkill rofi || ~/.config/rofi/scripts/powermenu.sh"

require("modules.animations")
require("modules.autostart")
require("modules.decorations")
require("modules.keybindings")
require("modules.monitors")
require("modules.windows")
require("modules.workspaces")

-- -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
-- hl.config({
--     dwindle = {
--         preserve_split = true, -- You probably want this
--     },
-- })

-- -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
-- hl.config({
--     master = {
--         new_status = "master",
--     },
-- })

-- -- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
-- hl.config({
--     scrolling = {
--         fullscreen_on_one_column = true,
--     },
-- })

hl.config({
    misc = {
        force_default_wallpaper = 0,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
