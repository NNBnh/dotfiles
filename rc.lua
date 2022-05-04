local gears = require("gears")
local awful = require("awful")


local function set_wallpaper()
	gears.wallpaper.maximized(awful.util.get_configuration_dir() .. "wallpaper.png")
end

set_wallpaper()

screen.connect_signal("property::geometry", set_wallpaper)


globalkeys = gears.table.join(
	awful.key({"Mod4"         }, "Tab", function() awful.client.focus.byidx( 1) end),
	awful.key({"Mod4", "Shift"}, "Tab", function() awful.client.focus.byidx(-1) end),

	awful.key({"Mod4"}, "Return", function() awful.util.spawn("kitty", false) end),

	awful.key({}, "XF86AudioMute",         function() awful.util.spawn("pactl set-sink-mute   @DEFAULT_SINK@ toggle", false) end),
	awful.key({}, "XF86AudioRaiseVolume",  function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%",    false) end),
	awful.key({}, "XF86AudioLowerVolume",  function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%",    false) end),
	awful.key({}, "XF86MonBrightnessUp",   function() awful.util.spawn("brightnessctl set 5%+",                       false) end),
	awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn("brightnessctl set 5%-",                       false) end),

	awful.key({         }, "Print", function() awful.util.spawn("scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f'",                   false) end),
	awful.key({"Control"}, "Print", function() awful.util.spawn("scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f' --select --freeze", false) end)
)

clientkeys = gears.table.join(
	awful.key({"Mod4"}, "Up",   function(c) c.fullscreen = true;                            end),
	awful.key({"Mod4"}, "Down", function(c) c:kill(); awful.client.focus.history.previous() end)
)

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
	awful.button({}, 2, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
	awful.button({}, 3, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),

	awful.button({"Mod4"}, 1, function(c) c:raise(); c.fullscreen = false; awful.mouse.client.move(c)   end),
	awful.button({"Mod4"}, 2, function(c) c:kill(); awful.client.focus.history.previous()               end),
	awful.button({"Mod4"}, 3, function(c) c:raise(); c.fullscreen = false; awful.mouse.client.resize(c) end)
)

root.keys(globalkeys)


awful.screen.connect_for_each_screen(
	function(s)
		awful.tag({"main"}, s, awful.layout.suit.floating)
	end
)

awful.rules.rules = {
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.centered
		}
	},
	{
		rule_any = {type = {"normal"}},
		properties = {fullscreen = true}
	},
	{
		rule_any = {icon_name = {"Picture-in-Picture"}},
		properties = {ontop = true}
	}
}

client.connect_signal(
	"manage",
	function(c)
		if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_offscreen(c)
		end
	end
)

awful.spawn.with_shell([[
	xset r rate 300 30
	kill picom; picom --experimental-backends --backend glx --blur-method dual_kawase --shadow &
	kill fcitx5; fcitx5 &
]])
