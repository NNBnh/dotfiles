# -*- coding: utf-8 -*-
#    ____  __  _ __
#   / __ \/ /_(_) /__
#  / / / / __/ / / _ \
# / /_/ / /_/ / /  __/
# \___\_\__/_/_/\___/


from typing          import List #TODO
from libqtile        import layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy   import lazy
from pathlib         import Path #TODO


# =============================================================================
# 1. Setting
# =============================================================================

layouts = [
	layout.Columns(
		border_normal       = "#000000", #TODO
		border_normal_stack = "#000000", #TODO
		border_focus        = "#FFFFFF", #TODO
		border_focus_stack  = "#FFFFFF", #TODO
		border_width        = 1,

		grow_amount     = 1,
		insert_position = 1,
		margin          = 16, #TODO
		num_columns     = 2,  #TODO

		wrap_focus_columns = False,
		wrap_focus_rows    = False,
		wrap_focus_stacks  = False
	)
]

screens = [
	Screen(
		wallpaper = str(Path.home()) + "/.config/background", #TODO
		wallpaper_mode = "fill"
		)
	)
]

bring_front_click = "floating_only"
auto_minimize     = True


# =============================================================================
# 1. Interactive
# =============================================================================

mouse = [
	Drag(["mod4"],          "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag(["mod4", "shift"], "Button1", lazy.window.set_size_floating(),     start=lazy.window.get_size()    )
]

keys = [
	Key(["mod4", "mod1"], "u", lazy.layout.swap_column_left() ),
	Key(["mod4", "mod1"], "o", lazy.layout.swap_column_right()),

	Key(["mod4"], "h", lazy.layout.toggle_split()),
	Key(["mod4"], "y", lazy.layout.normalize()   ),

	Key(["mod4"],            ";",      lazy.spawn("st")  ), #TODO
	Key(["mod4"],            "x",      lazy.window.kill()),
	Key(["mod4", "control"], "z",      lazy.restart()    ),
	Key(["mod4", "control"], "Escape", lazy.shutdown()   )
]

for direction, key in {
	"up":    "i",
	"down":  "k",
	"left":  "j",
	"right": "l",
}.items():
	keys.extend([
		Key(["mod4"],          key, getattr(lazy.layout,              direction)(), desc=f"Move focus {direction}" ),
		Key(["mod4", "mod1"],  key, getattr(lazy.layout, "shuffle_" + direction)(), desc=f"Move window {direction}"),
		Key(["mod4", "shift"], key, getattr(lazy.layout,    "grow_" + direction)(), desc=f"Grow window {direction}")
	])

for group in [Group(i) for i in "asdfgqwert"]:
	keys.extend([
		Key(["mod4"],         group.name, lazy.group[group.name].toscreen(),                  desc=f"Switch to group {group.name}"),
		Key(["mod4", "mod1"], group.name, lazy.window.togroup(group.name, switch_group=True), desc=f"Move window to group {group.name}"),
	])
