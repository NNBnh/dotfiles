from typing import List 
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from pathlib import Path

terminal = "st"


keys = [
	# Key(["mod4"], "Super_R", lazy.layout.next(), desc="Move window focus to other window"),
	Key(["mod4"], "slash", lazy.spawn(terminal), desc="Launch terminal"),
	Key(["mod4"], "x", lazy.window.kill(), desc="Kill focused window"),
	Key(["mod4"], "r", lazy.layout.normalize(), desc="Reset all window sizes"),
	Key(["mod4", "control"], "r", lazy.restart(), desc="Restart Qtile"),
	Key(["mod4", "control"], "Escape", lazy.shutdown(), desc="Shutdown Qtile"),
]

mouse = [
	Drag(["mod4"],          "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag(["mod4", "shift"], "Button1", lazy.window.set_size_floating(),     start=lazy.window.get_size()),
]

for direction, key in {
	"up":    "i",
	"down":  "k",
	"left":  "j",
	"right": "l",
}.items():
	keys.extend([
		Key(["mod4"],          key, getattr(lazy.layout,              direction)(), desc=f"Move focus {direction}"),
		Key(["mod4", "mod1"],  key, getattr(lazy.layout, "shuffle_" + direction)(), desc=f"Move window {direction}"),
		Key(["mod4", "shift"], key, getattr(lazy.layout,    "grow_" + direction)(), desc=f"Grow window {direction}"),
	])

groups = [Group(i) for i in "qwe"]
for group in groups:
	keys.extend([
		Key(["mod4"],         group.name, lazy.group[group.name].toscreen(),                  desc=f"Switch to group {group.name}"),
		Key(["mod4", "mod1"], group.name, lazy.window.togroup(group.name, switch_group=True), desc=f"Move window to group {group.name}"),
	])


layouts = [layout.Columns()]


widget_defaults = dict(
	font="Bmono",
	fontsize=12,
	padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
	Screen(
		wallpaper = str(Path.home()) + "/c/extra/wallpapers/live-from-squid-research-lab/the-reef.jpg",
		wallpaper_mode = "fill",
		bottom=bar.Bar(
			[
				widget.GroupBox(),
				widget.Prompt(),
				widget.WindowName(),
				widget.Chord(
					chords_colors={
						'launch': ("#ff0000", "#ffffff"),
					},
					name_transform=lambda name: name.upper(),
				),
				widget.Systray(),
				widget.Clock(format='%d/%m/%Y %I:%M %p'),
			],
			24,
		),
	),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
floating_layout = layout.Floating(float_rules=[
	# Run the utility of `xprop` to see the wm class and name of an X client.
	*layout.Floating.default_float_rules,
	Match(wm_class='confirmreset'),  # gitk
	Match(wm_class='makebranch'),  # gitk
	Match(wm_class='maketag'),  # gitk
	Match(wm_class='ssh-askpass'),  # ssh-askpass
	Match(title='branchdialog'),  # gitk
	Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
