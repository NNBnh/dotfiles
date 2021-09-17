from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from pathlib import Path

terminal = "st"

keys = [
	# Switch between windows
	Key(["mod4"], "i", lazy.layout.up(), desc="Move focus up"),
	Key(["mod4"], "k", lazy.layout.down(), desc="Move focus down"),
	Key(["mod4"], "j", lazy.layout.left(), desc="Move focus left"),
	Key(["mod4"], "l", lazy.layout.right(), desc="Move focus right"),
	Key(["mod4"], "space", lazy.layout.next(), desc="Move window focus to other window"),
	Key(["mod4", "mod1"], "i", lazy.layout.shuffle_up(), desc="Move window up"),
	Key(["mod4", "mod1"], "k", lazy.layout.shuffle_down(), desc="Move window down"),
	Key(["mod4", "mod1"], "j", lazy.layout.shuffle_left(), desc="Move window left"),
	Key(["mod4", "mod1"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
	Key(["mod4", "shift"], "i", lazy.layout.grow_up(), desc="Grow window up"),
	Key(["mod4", "shift"], "k", lazy.layout.grow_down(), desc="Grow window down"),
	Key(["mod4", "shift"], "j", lazy.layout.grow_left(), desc="Grow window left"),
	Key(["mod4", "shift"], "l", lazy.layout.grow_right(), desc="Grow window right"),

	Key(["mod4"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
	Key(["mod4"], "x", lazy.window.kill(), desc="Kill focused window"),
	Key(["mod4"], "r", lazy.layout.normalize(), desc="Reset all window sizes"),
	Key(["mod4", "control"], "r", lazy.restart(), desc="Restart Qtile"),
	Key(["mod4", "control"], "Escape", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
	keys.extend([
		# mod1 + letter of group = switch to group
		Key(["mod4"], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),

		# mod1 + shift + letter of group = switch to & move focused window to group
		Key(["mod4", "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
		# Or, use below if you prefer not to switch to that group.
		# # mod1 + shift + letter of group = move focused window to group
		# Key(["mod4", "shift"], i.name, lazy.window.togroup(i.name),
		#     desc="move focused window to group {}".format(i.name)),
	])

layouts = [
	layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
	layout.Max(),
	# Try more layouts by unleashing below layouts.
	# layout.Stack(num_stacks=2),
	# layout.Bsp(),
	# layout.Matrix(),
	# layout.MonadTall(),
	# layout.MonadWide(),
	# layout.RatioTile(),
	# layout.Tile(),
	# layout.TreeTab(),
	# layout.VerticalTile(),
	# layout.Zoomy(),
]

widget_defaults = dict(
	font='sans',
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
				widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
			],
			24,
		),
	),
]

# Drag floating layouts.
mouse = [
	Drag(["mod4"], "Button1", lazy.window.set_position_floating(),
		 start=lazy.window.get_position()),
	Drag(["mod4"], "Button3", lazy.window.set_size_floating(),
		 start=lazy.window.get_size()),
	Click(["mod4"], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
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
