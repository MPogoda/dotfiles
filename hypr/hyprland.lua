hl.monitor({
	output = "",
	mode = "preferred",
	bitdepth = 10,
	cm = "hdr",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDB_BACKEND", "wayland,x11,*")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("GDK_SCALE", "1")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DBUS_REMOTE", "1")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

hl.config({
	input = {
		kb_layout = "us,ua",
		kb_variant = "colemak",
		kb_model = "pc105",
		kb_options = "grp:rctrl_rshift_toggle,compose:ralt",

		follow_mouse = 1,
	},
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		col = {

			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},

	decoration = { rounding = 8 },

	dwindle = { preserve_split = true },

	misc = { focus_on_activate = true },

	animations = { enabled = true },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Tag all windows for default opacity (apps can override with -default-opacity tag)
hl.window_rule({ tag = "+default-opacity", match = { class = ".*" } })

hl.window_rule({ opacity = "0.97 0.9", match = { tag = "default-opacity" } })

-- # Browser types
hl.window_rule({ tag = "+firefox-based-browser", match = { class = "([fF]irefox|zen|librewolf)" } })
hl.window_rule({ tag = "-default-opacity", match = { tag = "firefox-based-browser" } })
hl.window_rule({ match = { tag = "floating-window" }, float = true })
hl.window_rule({ match = { tag = "floating-window" }, center = true })
hl.window_rule({ match = { tag = "floating-window" }, size = { 875, 600 } })

hl.window_rule({ tag = "+floating-window", match = { class = "(About|TUI.float|imv|mpv)" } })
hl.window_rule({
	tag = "+floating-window",
	match = {
		class = "(xdg-desktop-portal-gtk|DesktopEditors)",
		title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
	},
})
-- No transparency on media windows
hl.window_rule({ tag = "-default_opacity", match = { class = "^(mpv)$" } })
hl.window_rule({ opacity = "1 1", match = { class = "^(mpv)$" } })

-- Popped window rounding
hl.window_rule({ rounding = 8, match = { tag = "pop" } })

-- Prevent idle while open
hl.window_rule({ idle_inhibit = "always", match = { tag = "noidle" } })

-- Define terminal tag to style them uniformly
hl.window_rule({ tag = "+terminal", match = { class = "(Alacritty|kitty|com.mitchellh.ghostty)" } })
hl.window_rule({ tag = "-default-opacity", match = { tag = "terminal" } })
hl.window_rule({ opacity = "0.97 0.9", match = { tag = "terminal" } })
hl.window_rule({ float = true, match = { class = "^(org.pulseaudio.pavucontrol)$" } })
hl.window_rule({ float = true, match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" } })

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd('walker -p "start…"'), { description = "launch apps" })
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("ghostty"))
hl.bind("SUPER + SHIFT + q", hl.dsp.window.kill("activewindow"))
hl.bind("SUPER + SHIFT + backspace", hl.dsp.exec_cmd("hyprshutdown -p 'systemctl poweroff'"))

hl.bind("SUPER + minus", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + 0", hl.dsp.window.pseudo())
hl.bind("SUPER + J", hl.dsp.window.pseudo())

hl.bind("SUPER + SHIFT + return", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind("SUPER + SHIFT + g", hl.dsp.group.toggle())
hl.bind("SUPER + CTRL + bracketleft", hl.dsp.group.prev())
hl.bind("SUPER + CTRL + bracketright", hl.dsp.group.next())

hl.bind("SUPER + bracketleft", hl.dsp.window.cycle_next({ next = false }))
hl.bind("SUPER + bracketright", hl.dsp.window.cycle_next())

hl.bind("SUPER + SHIFT + bracketleft", hl.dsp.window.swap({ prev = true }))
hl.bind("SUPER + SHIFT + bracketright", hl.dsp.window.swap({ next = true }))

for workspace, workspaceName in pairs({ "a", "r", "s", "t" }) do
	hl.bind("SUPER + " .. workspaceName, hl.dsp.focus({ workspace = workspace }))
	hl.bind("SUPER + SHIFT + " .. workspaceName, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind("SUPER + n", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + n", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
	hl.exec_cmd("waybar")
	hl.exec_cmd("dunst")
	hl.exec_cmd("/usr/lib64/libexec/polkit-kde-authentication-agent-1")
	hl.exec_cmd("hyprpaper")
end)
