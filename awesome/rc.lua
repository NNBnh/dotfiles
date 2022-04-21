pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local nice = require("nice")

nice()

-- Errors

if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end


-- Screens

local function set_wallpaper(s)
    gears.wallpaper.maximized(os.getenv("HOME") .. "/.local/share/wallpaper.png", s, true)
end

for s in screen do
   set_wallpaper(s)
   awful.tag({"main"}, s, awful.layout.suit.floating)
end

screen.connect_signal("property::geometry", set_wallpaper)


-- Keymaps

globalkeys = gears.table.join(
    awful.key(
        {"Mod4"},
        "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {"Mod4", "Shift"},
        "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
        {"Mod4"},
        "p",
        function()
            menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
    )
)

clientkeys = gears.table.join(
    awful.key(
        {"Mod4"},
        "Up",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        {"Mod4"},
        "Down",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    )
)

clientbuttons = gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    )
)

root.keys(globalkeys)


-- Environment

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    },
    {
        rule_any = {type = {"normal"}},
        properties = {fullscreen = true}
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

-- client.connect_signal(
    -- "request::titlebars",
    -- function(c)
        -- local buttons = gears.table.join(
            -- awful.button(
                -- {},
                -- 1,
                -- function()
                    -- c:emit_signal("request::activate", "titlebar", {raise = true})
                    -- awful.mouse.client.move(c)
                -- end
            -- ),
            -- awful.button(
                -- {},
                -- 3,
                -- function()
                    -- c:emit_signal("request::activate", "titlebar", {raise = true})
                    -- awful.mouse.client.resize(c)
                -- end
            -- )
        -- )
-- 
        -- awful.titlebar(c):setup {
            -- {
                -- awful.titlebar.widget.iconwidget(c),
                -- buttons = buttons,
                -- layout = wibox.layout.fixed.horizontal
            -- },
            -- {
                -- {
                    -- align = "center",
                    -- widget = awful.titlebar.widget.titlewidget(c)
                -- },
                -- buttons = buttons,
                -- layout = wibox.layout.flex.horizontal
            -- },
            -- {
                -- awful.titlebar.widget.closebutton(c),
                -- layout = wibox.layout.fixed.horizontal()
            -- },
            -- layout = wibox.layout.align.horizontal
        -- }
    -- end
-- )
