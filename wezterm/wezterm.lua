local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "catppuccin-mocha"

config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = {
	saturation = 0.3,
	brightness = 0.8,
}

config.native_macos_fullscreen_mode = true

config.font = wezterm.font("Iosevka SS09")
config.font_size = 13

config.quick_select_alphabet = "arstqwfpzxcvneioluymdhgjbk"
config.leader = { key = "t", mods = "ALT" }
config.keys = {
	{ key = "n", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "i", mods = "LEADER", action = wezterm.action.PaneSelect({ mode = "Activate" }) },
	{ key = "i", mods = "LEADER|SHIFT", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "o", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
}

return config
