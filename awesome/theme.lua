theme                       = { }
theme.confdir               = awful.util.getdir("config")

theme.bg_focus              = "#dddddd"
theme.bg_normal             = "#70a0b0" --ffcc5f
theme.bg_urgent             = theme.bg_focus

theme.border_focus          = theme.bg_focus
theme.border_marked         = theme.bg_focus
theme.border_normal         = theme.bg_normal
theme.border_width          = 1

theme.fg_focus              = "#000000"
theme.fg_normal             = "#101010"
theme.fg_urgent             = theme.fg_focus

theme.font                  = "URW Gothic L 10"

theme.layout_fullscreen     = theme.confdir .. "/icons/fullscreen.png"
theme.layout_tile           = theme.confdir .. "/icons/tile.png"
theme.layout_tilebottom     = theme.confdir .. "/icons/tilebottom.png"
theme.layout_floating       = theme.confdir .. "/icons/floating.png"

theme.taglist_squares_sel   = theme.confdir .. "/icons/squarefz.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/squarez.png"

theme.wallpaper_cmd         = { "awsetbg " .. theme.confdir .. "/wallpapers/TronLightCycle1.png" }

return theme
