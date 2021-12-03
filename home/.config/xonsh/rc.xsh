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

$PATH += [$XDG_DATA_HOME + "/gem/ruby/3.0.0/bin"]

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

aliases["ddg"] = "$BROWSER https://duckduckgo.com/?q=@($args) all>/dev/null &; disown"

def _roll():
	"Reload the Rickroll"
	pyperclip.copy("curl -sL 'http://bit.ly/10hA8iC' | bash")
aliases["roll"] = _roll
aliases["rollout"] = "curl -sL 'http://bit.ly/10hA8iC' | bash"

def _cht(args, stdin=None):
	print(requests.get("https://cheat.sh/" + ' '.join(args)).text)
aliases["cht"] = _cht

def _wttr(args, stdin=None):
	"wttr.in"
	print(requests.get("https://wttr.in/" + ' '.join(args)).text)
aliases["wttr"] = _wttr

def _wttr2(args, stdin=None):
	"v2.wttr.in"
	print(requests.get("https://v2.wttr.in/" + ' '.join(args)).text)
aliases["wttr2"] = _wttr2

def _rate(args, stdin=None):
	"rate.sx"
	print(requests.get("https://rate.sx/" + ' '.join(args)).text)
aliases["rate"] = _rate

def sysfetch():
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

def diyship_prompt():
	last_cmd = __xonsh__.history[-1] if __xonsh__.history else None

	status = last_cmd.rtn if last_cmd else 0
	duration = round(last_cmd.ts[1] - last_cmd.ts[0]) if last_cmd else 0

	command_info = ""

	if status != 0:
		command_info += " \033[91mE:" + str(status) + "\033[0m"

	if duration >= 2:
		command_info += " \033[90mtook\033[0m \033[93m" + str(datetime.timedelta(seconds = duration)) + "\033[0m"

	if (status != 0) or (duration >= 2):
		command_info += "\n"

	return "\n\033[0m" + command_info + "\033[1;94m:\033[0m "
$PROMPT = diyship_prompt

def diyship_title():
	return os.getcwd().replace(os.path.expanduser("~"), "~")
$TITLE = diyship_title
