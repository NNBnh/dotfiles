# -*- coding: utf-8 -*-

import os, requests, distro, datetime, re, pyperclip
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

$USERXSESSION = $XDG_CACHE_HOME + "/x11/xsession"
$USERXSESSIONRC = $XDG_CACHE_HOME + "/x11/xsessionrc"
$ALTUSERXSESSION = $XDG_CACHE_HOME + "/x11/Xsession"
$ERRFILE = $XDG_CACHE_HOME + "/x11/xsession-errors"
$XINITRC = $XDG_CONFIG_HOME + "/X11/xinitrc"
$XSERVERRC = $XDG_CONFIG_HOME + "/X11/xserverrc"
$ICEAUTHORITY = $XDG_CACHE_HOME + "/ICEauthority"
$INPUTRC = $XDG_CONFIG_HOME + "/readline/inputrc"
$GNUPGHOME = $XDG_DATA_HOME + "/gnupg"


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


$XONSH_CAPTURE_ALWAYS = True
$AUTO_CD = True
$COMPLETE_DOTS = True
$DOTGLOB = True
$MULTILINE_PROMPT = "│"
$XONSH_AUTOPAIR = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_DISPLAY = "single"


aliases["-"] = "cd -"
aliases["."] = "exa --all --group-directories-first --long --header --across --git"

abbrevs["o"] = "xdg-open"
abbrevs["e"] = $EDITOR
abbrevs["g"] = "git"


#TODO
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


def pretty_ls():
	exa --all --group-directories-first

def hr():
	print("\033[?7l\033[38;5;8m" + "_" * os.get_terminal_size().columns + "\033[?7h")

@events.on_postcommand
def command_info(cmd, rtn, out, ts, **kw):
	info_string = ""

	if rtn != 0:
		info_string += " \033[38;5;9mE:" + str(rtn)

	duration = round(ts[1] - ts[0])
	if duration >= 2:
		info_string += " \033[38;5;8mtook \033[38;5;11m" + str(datetime.timedelta(seconds = duration))

	if out or info_string:
		hr()

	if info_string:
		print("\033[A\033[" + str(os.get_terminal_size().columns - len(re.sub("\\033\\[[0-9;]*[JKmsu]", "", info_string)) - 1) + f"C{info_string} ")

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	print(f"\033[38;5;8m{olddir} -> {newdir}:\033[0m")
	pretty_ls()
	print("\033[A")

$PROMPT = "\033[1m$ "

$TITLE = lambda: os.getcwd().replace(os.path.expanduser("~"), "~")

def sysfetch():
	elements = ["os", "wm", "shell", "terminal", "editor"]
	pad = len(max(elements, key = len))
	infos = {
		"os":       distro.name(),
		"wm":       "Qtile",
		"shell":    os.path.basename($SHELL).capitalize(),
		"terminal": $TERMINAL.capitalize(),
		"editor":   $EDITOR.capitalize()
	}

	sysfetch_info = ""
	for element in elements:
		sysfetch_info += "\033[1;38;5;12m{lable}  \033[0m{info}\n".format( #TODO
			lable = element.upper().ljust(pad),
			info  = infos[element]
		)

	print(sysfetch_info)

sysfetch()
pretty_ls()
hr()
