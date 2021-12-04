# -*- coding: utf-8 -*-

import os, subprocess, distro, pyperclip, re, datetime, requests

xontrib load onepath
xontrib load abbrevs


$PATH += [f"{$HOME}/.local/bin"]

if os.path.exists(f"{$HOME}/.nix-profile") and not __xonsh__.env.get("NIX_PATH"):
	$NIX_REMOTE           = "daemon"
	$NIX_USER_PROFILE_DIR = f"/nix/var/nix/profiles/per-user/{$HOME}"
	$NIX_PROFILES         = f"/nix/var/nix/profiles/default {$HOME}/.nix-profile"
	$NIX_SSL_CERT_FILE    = "/etc/ssl/certs/ca-certificates.crt"
	$NIX_PATH             = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"

	$PATH += [f"{$HOME}/.nix-profile/bin", "/nix/var/nix/profiles/default/bin"]

$INPUTRC   = f"{$XDG_CONFIG_HOME}/readline/inputrc"
$GNUPGHOME = f"{$XDG_DATA_HOME}/gnupg"


$EDITOR   = "kak"
$VISUAL   = $EDITOR
$PAGER    = $EDITOR
$MANPAGER = $EDITOR
$TERMINAL = "st"
$BROWSER  = "brave"


$GTK_IM_MODULE = "fcitx"
$QT_IM_MODULE  = $GTK_IM_MODULE
$SDL_IM_MODULE = $GTK_IM_MODULE
$XMODIFIERS    = f"@im={$GTK_IM_MODULE}"



$XONSH_CAPTURE_ALWAYS     = True
$AUTO_CD                  = True
$COMPLETE_DOTS            = True
$DOTGLOB                  = True
$MULTILINE_PROMPT         = "│"
$XONSH_AUTOPAIR           = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_DISPLAY      = "single"


$XONTRIB_ONEPATH_ACTIONS = {
	"text/":   $EDITOR,
	"<FILE>":  "xdg-open",
	"<XFILE>": "<RUN>"
}

aliases[","] = "clear"
aliases["."] = "exa --all --group-directories-first --long --header --across --git"
aliases["-"] = "cd -"

abbrevs["e"] = $EDITOR
abbrevs["o"] = "xdg-open"
abbrevs["g"] = "git"

aliases["hr"] = lambda args=["#"]: [print("\033[?7l" + string * os.get_terminal_size().columns + "\033[?7h") for string in args]

aliases["cht"]   = lambda args: print(requests.get("https://cheat.sh/"   + " ".join(args)).text)
aliases["wttr"]  = lambda args: print(requests.get("https://wttr.in/"    + " ".join(args)).text)
aliases["wttr2"] = lambda args: print(requests.get("https://v2.wttr.in/" + " ".join(args)).text)
aliases["rate"]  = lambda args: print(requests.get("https://rate.sx/"    + " ".join(args)).text)

$roll = "curl -sL 'http://bit.ly/10hA8iC' | bash"
aliases["roll"] = lambda: pyperclip.copy($roll)
aliases["rollout"] = $roll

$lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
aliases["lorem"] = lambda args=[1]: pyperclip.copy("\n".join([$lorem] * int(args[0]))) #FIXME


def pretty_ls():
	exa --all --group-directories-first

def prompt_hr():
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
		prompt_hr()

	if info_string:
		print("\033[A\033[" + str(os.get_terminal_size().columns - len(re.sub("\\033\\[[0-9;]*[JKmsu]", "", info_string)) - 1) + f"C{info_string} ")

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	print(f"\033[38;5;8m{olddir} -> {newdir}:\033[0m")
	pretty_ls()
	print("\033[A")

$PROMPT = "\033[1m$ "

$TITLE = lambda: os.getcwd().replace($HOME, "~")

def sysfetch():
	fetch = {
		"os":       distro.name(),
		"wm":       "Qtile",
		"shell":    os.path.basename($SHELL).capitalize(),
		"terminal": $TERMINAL.capitalize(),
		"editor":   $EDITOR.capitalize()
	}

	pad = len(max([lable for lable, _ in fetch.items()], key = len))

	sysfetch_info = "\n".join(
		[
			"\033[1;38;5;{color}m{format_lable}  \033[0m{format_info}".format(
				color = 12, #TODO
				format_lable = lable.upper().ljust(pad),
				format_info  = info
			) for lable, info in fetch.items()
		]
	)

	print(sysfetch_info)

sysfetch()
prompt_hr()
