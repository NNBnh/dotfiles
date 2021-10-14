# -*- coding: utf-8 -*-

import os, shutil, glob, dploy

# Create directories (to only symlink files inside, not the directory)
for directory in [
	os.environ["XDG_CONFIG_HOME"] + "/fcitx",  os.environ["XDG_CONFIG_HOME"] + "/kak",  os.environ["XDG_CONFIG_HOME"] + "/retroarch",
	os.environ["XDG_DATA_HOME"] + "/fonts",  os.environ["XDG_DATA_HOME"] + "/icons",
	os.environ["XDG_DATA_HOME"], os.environ["XDG_DESKTOP_DIR"], os.environ["HOME"] + "/.local/bin"
]:
	os.makedirs(directory, exist_ok=True)

# Remove junks (Spring cleaning your $HOME)
junk_path = os.environ["XDG_CACHE_HOME"] + "/junks"
os.makedirs(junk_path, exist_ok=True)
for junk in os.listdir(os.environ["HOME"]):
	if junk not in [".config", ".local", ".cache", "c", "d", "i", "m", "t"]:
		shutil.move(junk, junk_path)

# Stop LightDM from making $HOME/.Xauthority (Spring cleaning your $HOME)
if os.path.isfile("/etc/lightdm/lightdm.conf"):
	with open("/etc/lightdm/lightdm.conf", 'a') as lightdm_config:
		lightdm_config.write("""
		[LightDM]
		user-authority-in-system-dir=true""".replace("	", ""))

# Change XDG directories
if shutil.which("xdg-user-dirs-update"):
	for xdg_directory in ["DESKTOP", "DOCUMENTS", "DOWNLOAD", "MUSIC", "PICTURES", "PUBLICSHARE", "TEMPLATES", "VIDEOS"]:
		xdg_path = os.environ[f"XDG_{xdg_directory}_DIR"]
		os.system("xdg-user-dirs-update --set '{xdg_directory}' '{xdg_path}'")

# Change default shell
os.system("sudo chsh -s " + shutil.which("xonsh"))

# Enable firewall
if shutil.which("ufw"):
	os.system("sudo ufw enable")

# Symlinks
dploy.stow(["home"], os.environ["HOME"])
