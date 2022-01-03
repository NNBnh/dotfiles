# -*- coding: utf-8 -*-

from libqtile        import layout
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy   import lazy


# =============================================================================
# 1. Setting
# =============================================================================

layouts = [
	layout.Columns(
		border_width    = 0,

		grow_amount     = 1,
		insert_position = 1,
		margin          = 16,

		wrap_focus_columns = False,
		wrap_focus_rows    = False,
		wrap_focus_stacks  = False
	)
]

screens = [
	Screen(
		wallpaper = "~/.local/share/wallpaper.png",
		wallpaper_mode = "fill"
	)
]

bring_front_click = "floating_only"
auto_minimize     = True


# =============================================================================
# 2. Interactive
# =============================================================================

keys = [
	Key(["mod4", "mod1"], "u", lazy.layout.swap_column_left()),
	Key(["mod4", "mod1"], "o", lazy.layout.swap_column_right()),

	Key(["mod4"], "p", lazy.layout.normalize()),

	Key(["mod4"], "semicolon", lazy.spawn("kitty")), #TODO
	Key(["mod4"], "x",         lazy.window.kill()),
	Key(["mod4"], "Escape",    lazy.shutdown())
]

for direction, key in {
	"up":    "i",
	"down":  "k",
	"left":  "j",
	"right": "l"
}.items():
	keys.extend([
		Key(["mod4"],          key, getattr(lazy.layout,              direction)()),
		Key(["mod4", "mod1"],  key, getattr(lazy.layout, "shuffle_" + direction)()),
		Key(["mod4", "shift"], key, getattr(lazy.layout,    "grow_" + direction)())
	])

groups = [Group(i) for i in "asdfqwer"]
for group in groups:
	keys.extend([
		Key(["mod4"],         group.name, lazy.group[group.name].toscreen()),
		Key(["mod4", "mod1"], group.name, lazy.window.togroup(group.name, switch_group=True))
	])
