require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")

require("vicious")
require("scratch")

local confdir = awful.util.getdir("config")

do
  local in_error = false
  awesome.add_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, an error happened!",
                     text = err })
    in_error = false
  end)
end


beautiful.init(confdir .. "/theme.lua")

local function exec(name)
  awful.util.spawn_with_shell(name .. ">/dev/null 2>&1")
end

menu_ = awful.menu({
  items = {
    { "internets",
      {
        { "browser",  function () exec("chromium")    end },
        { "jabber",   function () exec("leechcraft")  end },
        { "wicd",     function () exec("wicd-gtk")    end },
        { "skype",    function () exec("skype")       end }
      }
    },
    { "develop",
      {
        { "editor",   function () exec("gvim")      end },
        { "texmaker", function () exec("texmaker")  end },
        { "qt ide",   function () exec("qtcreator") end },
        { "ide",      function () exec("kdevelop")  end },
        { "java ide", function () exec("idea")      end }
      }
    },
    { "other",
      {
        { "dolphin",  function () exec("dolphin")   end },
        { "gwenview", function () exec("gwenview")  end },
        { "wxmaxima", function () exec("wxmaxima")  end },
        { "okular",   function () exec("okular")    end }
      }
    },
    { "games",
      {
        { "kpatience",  "kpat"      },
        { "kmines",     "kmines"    },
        { "knetwalk",   "knetwalk"  }
      }
    }
  }
})

sterminal = "rxvt -name urxvt-am -e "

volume        = { }
volume.mute   = "amixer sset Master toggle -q"
volume.up     = "amixer sset Master 1%+ -q"
volume.down   = "amixer sset Master 1%- -q"
volume.mixer  = sterminal .. "alsamixer"

modkey = "Mod4"

layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.floating
}

tags =
{
  names   = { " 0 ", " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 " },
  layout  = {
    layouts[2], layouts[3], layouts[3], layouts[4], layouts[3],
                layouts[1], layouts[2], layouts[3], layouts[4] }
}

tags = awful.tag(tags.names, 1, tags.layout)
for i, t in ipairs(tags) do
  awful.tag.setproperty(t, "mwfact", 0.5)
end

separator       = widget({ type = "textbox" })
separator.text  = '    '

backlight       = widget({ type = "textbox" })
backlight.text  = ' . '
backlight:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec('/usr/bin/backlight toggle') end),
  awful.button({ }, 4, function () exec('/usr/bin/backlight up')     end),
  awful.button({ }, 5, function () exec('/usr/bin/backlight down')   end)
))

cpuwidget      = widget({ type = "textbox" })
cpuwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec(sterminal .. "htop") end)
))
vicious.register(cpuwidget, vicious.widgets.cpu, "cpu: $1%", 2)

memwidget      = widget({ type = "textbox" })
memwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec(sterminal .. "htop") end)
))
vicious.register(memwidget, vicious.widgets.mem, "memory: $1% ($2M)", 5)

netwidget      = widget({ type = "textbox" })
vicious.register(netwidget, vicious.widgets.net,
                              "net: ${wlan0 down_kb} (${wlan0 rx_mb}M)", 3)

datewidget      = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date,
      ' %a %d, <span color="' .. beautiful.fg_focus .. '"> %H:%M</span>', 60)

volwidget     = widget({ type = "textbox"})
vicious.cache(vicious.widgets.volume)
vicious.register(volwidget, vicious.widgets.volume, "volume: $1", 2, "Master")
volwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec(volume.mixer) end),
  awful.button({ }, 4, function () exec(volume.up)    end),
  awful.button({ }, 5, function () exec(volume.down)  end)
))

batwidget      = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "battery: $2", 61, "BAT1")
batwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () exec(sterminal .. "htop") end)
))

systray = widget({ type = "systray" })

wibox     = {}
promptbox = {}
layoutbox = {}
taglist   = {}

taglist.buttons = awful.util.table.join(
  awful.button({        }, 1, awful.tag.viewonly      ),
  awful.button({        }, 3, awful.tag.viewtoggle    ),
  awful.button({ modkey }, 3, awful.client.toggletag  ),
  awful.button({        }, 4, awful.tag.viewnext      ),
  awful.button({        }, 5, awful.tag.viewprev      )
)

promptbox = awful.widget.prompt({
  layout  = awful.widget.layout.horizontal.leftright
})
layoutbox = awful.widget.layoutbox(1)
layoutbox:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.layout.inc(layouts, 1)    end),
  awful.button({ }, 3, function () awful.layout.inc(layouts, -1)  end)
))

taglist = awful.widget.taglist(1, awful.widget.taglist.label.all,
            taglist.buttons)

wibox = awful.wibox({
  position      = "top",
  screen        = 1,
  height        = 18,
  fg            = beautiful.fg_normal,
  bg            = beautiful.bg_normal,
  border_color  = beautiful.border_normal,
  border_width  = beautiful.border_width
})
wibox.widgets  = {
  {
    backlight,
    taglist,
    promptbox,
    ["layout"] = awful.widget.layout.horizontal.leftright
  },
  layoutbox,
  separator, systray,
  separator, datewidget,
  separator, netwidget,
  separator, memwidget,
  separator, cpuwidget,
  separator, batwidget,
  separator, volwidget,
  ["layout"] = awful.widget.layout.horizontal.rightleft
}

root.buttons(awful.util.table.join(
  awful.button({ }, 1, function () menu_:toggle() end ),
  awful.button({ }, 4, awful.tag.viewnext             ),
  awful.button({ }, 5, awful.tag.viewprev             )
))

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    client.focus = c
    c:raise()
  end),
  awful.button({ modkey }, 1, awful.mouse.client.move   ),
  awful.button({ modkey }, 3, awful.mouse.client.resize )
)

globalkeys = awful.util.table.join(
  awful.key({ modkey }, "Left",   awful.tag.viewprev),
  awful.key({ modkey }, "Right",  awful.tag.viewnext),
  awful.key({ modkey }, "j",      function ()
    awful.client.focus.byidx(1)
    if client.focus then
      client.focus:raise()
    end
  end),
  awful.key({ modkey }, "k",      function ()
    awful.client.focus.byidx(-1)
    if client.focus then
      client.focus:raise()
    end
  end),
  awful.key({ modkey, "Shift" },  "j",  function ()
    awful.client.swap.byidx(1)
  end),
  awful.key({ modkey, "Shift" },  "k",  function ()
    awful.client.swap.byidx(-1)
  end),
  awful.key({ modkey, "Shift" },  "r",  awesome.restart ),
  awful.key({ modkey, "Shift" },  "q",  awesome.quit    ),
  awful.key({ modkey }, "l",      function () awful.tag.incmwfact(0.05)     end),
  awful.key({ modkey }, "h",      function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey }, "space",  function () awful.layout.inc(layouts, 1)  end),
  awful.key({ modkey }, "r",      function () promptbox:run()               end),
  awful.key({ modkey }, "F3",     function ()
    wibox.visible = not wibox.visible
  end),

  awful.key({ "Control" }, "F11", function ()
    scratch.drop("rxvt", "bottom", nil, nil, 0.30)
  end),

  awful.key({ modkey }, "Return", function ()  exec("rxvt") end),
  awful.key({ modkey }, "s", scratch.pad.toggle ),

  awful.key({ "Control", modkey }, "n", function ()
    exec("rxvt -name ncmpc -e ncmpc-launcher.sh")
  end),
  awful.key({ "Control", modkey }, "s", function ()
    naughty.notify({
      text = awful.util.pread('mpc current --format "<span color=\'#' ..
                              beautiful.fg_focus .. '\'>%track%</span>.' ..
                              '%title%<br/>%artist%<br/>%album% (%date%)"'),
      icon = awful.util.pread('echo -n /data/music/$(dirname "$(mpc current ' ..
                              '--format "%file%")")"/folder.png"'),
      icon_size = 128
    })
  end),
  awful.key({ "Control", modkey }, "b", function () exec("chromium")    end),
  awful.key({ "Control", modkey }, "j", function () exec("leechcraft")  end),
  awful.key({ "Control", modkey }, "e", function () exec("gvim")        end),
  awful.key({ "Control", modkey }, "f", function () exec("dolphin")     end),
  awful.key({ "Control", modkey }, "g", function () exec("gwenview")    end),
  awful.key({ "Control", modkey }, "m", function () exec("wxmaxima")    end),
  awful.key({ "Control", modkey }, "z", function ()
    exec(sterminal .. "mc")
  end),
  awful.key({ "Control", modkey }, "o", function () exec("okular")      end),

  --backlight hotkeys
  awful.key({ "Mod1",    modkey }, "1", function ()
    exec("backlight A")
  end),
  awful.key({ "Mod1",    modkey }, "2", function ()
    exec("backlight B")
  end),
  awful.key({ "Mod1",    modkey }, "3", function ()
    exec("backlight C")
  end),
  awful.key({ "Mod1",    modkey }, "4", function ()
    exec("backlight D")
  end),
  awful.key({ "Mod1",    modkey }, "5", function ()
    exec("backlight off")
  end)
)

clientkeys = awful.util.table.join(
  awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey, "Shift" }, "c",       function (c) c:kill()          end),
  awful.key({ modkey, "Shift" }, "space",   awful.client.floating.toggle     ),
  awful.key({ modkey, "Shift" }, "Return",  function (c)
    c:swap(awful.client.getmaster())
  end),
  awful.key({ modkey }, "m", function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

for i = 1, 9 do
  globalkeys = awful.util.table.join(
    globalkeys,
    awful.key({ modkey }, i, function ()
      if tags[i] then
        awful.tag.viewonly(tags[i])
      end
    end),
    awful.key({ modkey, "Control" }, i, function ()
      if tags[i] then
        tags[i].selected = not tags[i].selected
      end
    end),
    awful.key({ modkey, "Shift" }, i, function ()
      if client.focus and tags[i] then
        awful.client.movetotag(tags[i])
      end
    end),
    awful.key({ modkey, "Control", "Shift" }, i, function ()
      if client.focus and tags[i] then
        awful.client.toggletag(tags[i])
      end
    end)
  )
end

root.keys(globalkeys)

awful.rules.rules = {
  {
    rule = { },
    properties =
    {
      focus              = true,
      keys              = clientkeys,
      buttons            = clientbuttons,
      border_width      = beautiful.border_width,
      border_color      = beautiful.border_normal,
      size_hints_honor  = false,
      switchtotag       = true
    }
  },
  {
    rule        = { class     = "MPlayer"         },
    properties  =  {  floating  = true              }
  },
  {
    rule        = { class     = "pinentry"        },
    properties  =  {  floating  = true              }
  },
  {
    rule        = { class     = "Xloadimage"      },
    properties  =  {  floating  = true              }
  },
  {
    rule        = { class     = "Firefox"         },
    properties  = { tag       = tags[2]           }
  },
  {
    rule        = { class     = "Firefox"         },
    except      = { instance  = "Navigator"       },
    properties  = { floating  = true              }
  },
  {
    rule        = { class     = "Chromium"        },
    properties  = { tag       = tags[2]           }
  },
  {
    rule       = { class      = "Konqueror"       },
    properties = { tag        = tags[2]           }
  },
  {
    rule        = { class     = "Arora"           },
    properties  = { tag       = tags[2]           }
  },
  {
    rule        = { class     = "psi"             },
    except      = { instance  = "tabs"            },
    properties  = { tag       = tags[9]           }
  },
  {
    rule       = { class      = "Qwit"            },
    properties = { tag        = tags[9]           }
  },
  {
    rule       = { class      = "Skype"           },
    properties = { tag        = tags[9]           }
  },
  {
    rule       = { class      = "Qbittorrent"     },
    properties = { tag        = tags[8]           }
  },
  {
    rule       = { class      = "Leechcraft"      },
    properties = { tag        = tags[8]           }
  },
  {
    rule       = { class      = "Eiskaltdcpp-qt"  },
    properties =
    {
      floating = false,
      tag      = tags[8]
    }
  },
  {
    rule       = { class      = "Dolphin"         },
    properties = { tag        = tags[4]           }
  },
  {
    rule       = { class      = "Gwenview"        },
    properties = { tag        = tags[4]           }
  },
  {
    rule       = { class      = "Picasa 3"        },
    properties = { tag        = tags[4]           }
  },
  {
    rule       = { class      = "Wxmaxima"        },
    properties = { tag        = tags[6]           }
  },
  {
    rule       = { class      = "Okular"          },
    properties = { tag        = tags[5]           }
  },
  {
    rule        =
    {
      class     = "psi",
      instance  = "tabs"
    },
    callback    = function (c) scratch.pad.set(c, 0.6, 0.6, true) end
  }
}

client.add_signal("manage", function (c, startup)
  c:add_signal("mouse::enter", function(c)
    if awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end
end)
screen[1]:add_signal("arrange", function ()
    for _, c in pairs(awful.client.visible(s)) do
      if awful.client.floating.get(c) and not c.fullscreen then
        c.above = true
      else
        c.above = false
      end
    end
end)

exec(confdir .. "/scripts/autorun.sh")
