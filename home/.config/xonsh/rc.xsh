# -*- coding: utf-8 -*-

import os, platform, requests, datetime, pyperclip
xontrib load abbrevs


$XDG_CONFIG_HOME = $HOME + "/.config"
$XDG_CACHE_HOME = $HOME + "/.cache"
$XDG_DATA_HOME = $HOME + "/.local/share"

$XDG_DOCUMENTS_DIR = $HOME + "/d"
$XDG_PICTURES_DIR = $HOME + "/i"
$XDG_VIDEOS_DIR = $XDG_PICTURES_DIR
$XDG_MUSIC_DIR = $HOME + "/m"
$XDG_DESKTOP_DIR = $HOME + "/t"
$XDG_DOWNLOAD_DIR = $XDG_DESKTOP_DIR
$XDG_PUBLICSHARE_DIR = $XDG_DESKTOP_DIR
$XDG_TEMPLATES_DIR = $XDG_DESKTOP_DIR

# XAUTHORITY = $XDG_RUNTIME_DIR + "/Xauthority"
$USERXSESSION = $XDG_CACHE_HOME + "/x11/xsession"
$USERXSESSIONRC = $XDG_CACHE_HOME + "/x11/xsessionrc"
$ALTUSERXSESSION = $XDG_CACHE_HOME + "/x11/Xsession"
$ERRFILE = $XDG_CACHE_HOME + "/x11/xsession-errors"
$XINITRC = $XDG_CONFIG_HOME + "/X11/xinitrc"
$XSERVERRC = $XDG_CONFIG_HOME + "/X11/xserverrc"
$ICEAUTHORITY = $XDG_CACHE_HOME + "/ICEauthority"
$INPUTRC = $XDG_CONFIG_HOME + "/readline/inputrc"
$GNUPGHOME = $XDG_DATA_HOME + "/gnupg"
$CARGO_HOME = $XDG_DATA_HOME + "/cargo"
$GTK_RC_FILES = $XDG_CONFIG_HOME + "/gtk-1.0/gtkrc"
$GTK2_RC_FILES = $XDG_CONFIG_HOME + "/gtk-2.0/gtkrc"

$EDITOR = "kak"
$VISUAL = $EDITOR
$PAGER = $EDITOR
$MANPAGER = $EDITOR
$TERMINAL = "st"
$BROWSER = "brave"

$GTK_IM_MODULE = "fcitx"
$QT_IM_MODULE = $GTK_IM_MODULE
$SDL_IM_MODULE = $GTK_IM_MODULE
$XMODIFIERS = "@im=" + $GTK_IM_MODULE

abbrevs["o"] = "xdg-open"
abbrevs["e"] = $EDITOR
abbrevs["g"] = "git"

def _roll():
	"Reload the Rickroll"
	pyperclip.copy("curl -sL 'http://bit.ly/10hA8iC' | bash")
aliases["roll"] = "_roll()"

def _ifjson(): #TODO
	"ifconfig.co/json"
	print(requests.get("https://ifconfig.co/json").text)
aliases["ifjson"] = "_ifjson()"

def _cht(arg):
	"cheat.sh"
	print(requests.get("https://cheat.sh/" + str(arg)).text)
aliases["cht"] = "_cht()"

def _wttr(arg):
	"wttr.in"
	print(requests.get("https://wttr.in/" + str(arg)).text)
aliases["wttr"] = "_wttr()"

def _wttr2(arg):
	"v2.wttr.in"
	print(requests.get("https://v2.wttr.in/" + str(arg)).text)
aliases["wttr2"] = "_wttr2()"

def _rate(arg):
	"rate.sx"
	print(requests.get("https://rate.sx/" + str(arg)).text)
aliases["rate"] = "_rate()"

def _sysfetch():
	elements = ["os", "wm", "shell", "terminal", "font"]
	pad = len(max(elements, key = len))
	infos = {
		"os": platform.system() + " " + platform.release(), #TODO
		"wm": "Qtile", #TODO
		"shell": os.environ.get("SHELL"),
		"terminal": os.environ.get("TERMINAL"),
		"font": os.environ.get("FONT_MONO_FAMILY")
	}
	icons = {
		"os": "💾",
		"wm": "🖼 ",
		"shell": "🐚",
		"terminal": "📟",
		"font": "🏷 "
	}

	sysfetch_info = ""
	for element in elements:
		sysfetch_info += "\033[1;38;5;{color}m{lable}  \033[0m{icon} {info}\n".format(
				color = 2, #TODO
				lable = element.upper().ljust(pad),
				icon  = icons[element],
				info  = infos[element]
		)

	print(sysfetch_info)

def _diyship(): #TODO
	duration = os.environ.get("DIYSHIP_DURATION")
	status   = os.environ.get("DIYSHIP_STATUS")

	if duration >= 2000:
		datetime.timedelta(milliseconds = duration)

	if status >= 0:
		if status == "126":
			STATUS_SYMBOL = "🚫"
		if status == "127":
			STATUS_SYMBOL = "🔍"
		if status == "130":
			STATUS_SYMBOL = "🧱"
		else:
			STATUS_SYMBOL = "⚡"

	if os.path.exists(os.getcwd() + "/.git"):
		# GIT_BRANCH=$(git rev-parse --abbrev-ref 'HEAD' 2>/dev/null) \
		# && GIT_BRANCH="on \033[1;95m $GIT_BRANCH"

		# git symbolic-ref 'HEAD' 2>&1 >/dev/null || {
		# 	GIT_HASH=$(git rev-parse --verify --short 'HEAD' 2>/dev/null) \
		# 	&& GIT_HASH="\033[1;92m#$GIT_HASH"
		# }

		# GIT_TAG=$(git tag --points-at 'HEAD' 2>/dev/null) \
		# && [ -n "$GIT_TAG" ] && GIT_TAG="\033[1;93m🏷 $GIT_TAG"
		pass

	CWD  = os.getcwd() #TODO
	HOME = os.path.expanduser("~")
	if   CWD == HOME + "d/":
		CWD_SYMBOL = "🗃 "
	elif CWD == HOME + "c/":
		CWD_SYMBOL = "⚙ "
	elif CWD == HOME + "t/":
		CWD_SYMBOL = "⚗ "
	elif CWD == HOME:
		CWD_SYMBOL = "🏠"
	elif CWD == HOME:
		CWD_SYMBOL = "📂"
	else:
		CWD_SYMBOL = "📁"


# bfetch
# bui-terminal
