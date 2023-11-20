local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "catppuccin-mocha"

config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = {
	saturation = 0.3,
	brightness = 0.8,
}

config.native_macos_fullscreen_mode = true

config.harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }

config.font = wezterm.font({
	family = "Monaspace Neon",
	-- family = "Monaspace Argon",
	-- family = "Monaspace Xenon",
	-- family = "Monaspace Radon",
	-- family = "Monaspace Krypton",
	weight = "Regular",
})

-- https://wezfurlong.org/wezterm/config/lua/config/font_rules.html
-- wezterm ls-fonts
-- wezterm ls-fonts --list-system
config.font_rules = {
	-- Italic (comments)
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "Monaspace Radon",
			weight = "ExtraLight",
			stretch = "Normal",
			style = "Normal",
		}),
	},
	-- Bold (highlighting)
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "Monaspace Krypton",
			weight = "Light",
			stretch = "Normal",
			style = "Normal",
		}),
	},
}
config.font_size = 13
config.cell_width = 0.9

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
