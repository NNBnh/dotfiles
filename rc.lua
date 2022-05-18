require("awful.autofocus")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")


awful.screen.connect_for_each_screen(
	function(s)
		awful.tag({"main"}, s, awful.layout.suit.floating)
	end
)

local function set_wallpaper()
	gears.wallpaper.maximized(awful.util.get_configuration_dir() .. "wallpaper.png")
end

set_wallpaper()

screen.connect_signal("property::geometry", set_wallpaper)

awful.spawn.with_shell([[
	xset r rate 300 30
	kill picom; picom --experimental-backends --backend glx --blur-method dual_kawase --shadow &
	kill fcitx5; fcitx5 &
]])


root.keys(
	gears.table.join(
		awful.key({}, "XF86AudioMute",         function() awful.util.spawn("pactl set-sink-mute   @DEFAULT_SINK@ toggle", false) end),
		awful.key({}, "XF86AudioRaiseVolume",  function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%",    false) end),
		awful.key({}, "XF86AudioLowerVolume",  function() awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%",    false) end),

		awful.key({}, "XF86MonBrightnessUp",   function() awful.util.spawn("brightnessctl set 5%+", false) end),
		awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn("brightnessctl set 5%-", false) end),

		awful.key({         }, "Print", function() awful.util.spawn("scrot %Y-%m-%d.png -e 'xclip -selection clipboard -target image/png $f'",                   false) end),
		awful.key({"Control"}, "Print", function() awful.util.spawn("scrot %Y-%m-%d.png -e 'xclip -selection clipboard -target image/png $f' --select --freeze", false) end),

		-- TODO menu4all
		-- awful.key({"Mod4"}, "minus", function() end)
		awful.key({"Mod4"         }, "Return", function() awful.util.spawn("kitty",       false) end),
		awful.key({"Mod4"         }, "Escape", function() awful.util.spawn("xsecurelock", false) end),
		awful.key({"Mod4"         }, "Tab",    function() awful.client.focus.byidx( 1)           end),
		awful.key({"Mod4", "Shift"}, "Tab",    function() awful.client.focus.byidx(-1)           end)
	)
)

awful.rules.rules = {
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			buttons = gears.table.join(
				awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
				awful.button({}, 2, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
				awful.button({}, 3, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),

				awful.button({"Mod4"         }, 1, function(c) c:raise(); c.fullscreen = false; awful.mouse.client.move(c)   end),
				awful.button({"Mod4", "Shift"}, 1, function(c) c:raise(); c.fullscreen = false; awful.mouse.client.resize(c) end),
				awful.button({"Mod4"         }, 3, function(c) c:raise(); c.fullscreen = false; awful.mouse.client.resize(c) end),
				awful.button({"Mod4"         }, 2, function(c) c:kill();                                                     end)
			),
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


-- -- TODO
-- local menu4all = awful.popup {
	-- widget = awful.widget.tasklist {
		-- screen   = screen[1],
		-- filter = awful.widget.tasklist.filter.allscreen,
		-- buttons = tasklist_buttons,
		-- style = {
			-- shape = gears.shape.rect
		-- },
		-- layout = {
			-- spacing = 5,
			-- forced_num_rows = 2,
			-- layout = wibox.layout.grid.horizontal
		-- },
		-- widget_template = {
			-- {
				-- {
					-- id = "clienticon",
					-- widget = awful.widget.clienticon
				-- },
				-- margins = 4,
				-- widget = wibox.container.margin
			-- },
			-- id = "background_role",
			-- forced_width = 48,
			-- forced_height = 48,
			-- widget = wibox.container.background,
			-- create_callback = function(self, c, index, objects) --luacheck: no unused
				-- self:get_children_by_id("clienticon")[1].client = c
			-- end
		-- },
	-- },
	-- border_color = "#000000",
	-- border_width = 0,
	-- ontop = true,
	-- placement = awful.placement.centered,
	-- shape = gears.shape.rect
-- }
-- 
-- 
-- -- TODO
-- screen.connect_signal(
	-- "request::desktop_decoration",
	-- function(s)
		-- s.corner = wibox {
			-- x = s.geometry.x,
			-- y = s.geometry.y,
			-- visible = true,
			-- screen = s,
			-- ontop = true,
			-- opacity = 0.0,
			-- height = 1,
			-- width = 1,
			-- type = "utility"
		-- }
		-- s.corner:connect_signal(
			-- "mouse::enter",
			-- function()
				-- menu4all.visible = not menu4all.visible
	    	-- end
	    -- )
    -- end
-- )
-- 
-- -- FIXME A hack to always put the hot-corners on top
-- client.connect_signal(
	-- "property::fullscreen",
	-- function(c)
		-- focused = awful.screen.focused().corner
-- 
		-- focused.ontop = true
		-- focused.visible = false
		-- focused.visible = true
	-- end
-- )
