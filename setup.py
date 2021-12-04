# -*- coding: utf-8 -*-

import os, shutil

# Remove junks (Spring cleaning your $HOME)
junk_path = os.path.expanduser("~/.junks")
os.makedirs(junk_path, exist_ok=True)
for junk in os.listdir(os.path.expanduser("~")):
	if junk not in [".config", ".local", ".cache", "c", "d", "i", "m", "t"]:
		shutil.move(junk, junk_path)

# Change XDG directories
if shutil.which("xdg-user-dirs-update"):
	for directory, path in {
		"documents":   f"{$HOME}/d",
		"pictures":    f"{$HOME}/i",
		"videos":      f"{$HOME}/i",
		"music":       f"{$HOME}/m",
		"desktop":     f"{$HOME}/t",
		"download":    f"{$HOME}/t",
		"publicshare": f"{$HOME}/t",
		"templates":   f"{$HOME}/t"
	}.items():
		os.system(f"xdg-user-dirs-update --set '{directory}' '{path}'")
