# -*- coding: utf-8 -*-


import prompt_toolkit, os, subprocess, distro, pyperclip, re, datetime, requests
from prompt_toolkit.keys import Keys

xontrib load onepath
xontrib load abbrevs


# =============================================================================
# 1. Environment Variables
# =============================================================================

$GTK_IM_MODULE = "fcitx"
$QT_IM_MODULE  = $GTK_IM_MODULE
$SDL_IM_MODULE = $GTK_IM_MODULE
$XMODIFIERS    = f"@im={$GTK_IM_MODULE}"

## Path -----------------------------------------------------------------------

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

## Default Applications -------------------------------------------------------

$EDITOR   = "kak"
$VISUAL   = $EDITOR
$PAGER    = $EDITOR
$MANPAGER = $EDITOR
$TERMINAL = "st"
$BROWSER  = "brave"

## Xonsh Setting --------------------------------------------------------------

$XONSH_CAPTURE_ALWAYS     = True
$AUTO_CD                  = True
$COMPLETE_DOTS            = True
$DOTGLOB                  = True
$IGNOREEOF                = True
$MULTILINE_PROMPT         = "│"
$PROMPT                   = "\033[1m$ "
$TITLE                    = lambda: $PWD.replace($HOME, "~")
$XONSH_AUTOPAIR           = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_CONFIRM      = False
$COMPLETIONS_DISPLAY      = "single"

$XONTRIB_ONEPATH_ACTIONS = {
	"text/":   $EDITOR,
	"<FILE>":  "xdg-open",
	"<XFILE>": "<RUN>"
}

# =============================================================================
# 2. Function
# =============================================================================

def hr(string="#"):
	print("\033[?7l" + string * os.get_terminal_size().columns + "\033[?7h")

def prompt_hr():
	print(end="\033[38;5;8m")
	hr("_")

def pretty_ls():
	exa --all --group-directories-first
	print("\033[A")

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

## Events ---------------------------------------------------------------------

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	print(f"\033[38;5;8m{olddir} -> {newdir}:\033[0m")
	pretty_ls()

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

## Aliases --------------------------------------------------------------------

### Navigation
aliases["-"] = "cd -" #TODO Map to Alt-Left and Alt-Right

### Display
aliases["."] = "exa --all --group-directories-first --long --header --across --git"
aliases[","] = "clear; pretty_ls()" #TODO Map to Ctrl-R
aliases["hr"] = lambda args=["#"]: [hr(string) for string in args] #FIXME default parameter

### Services
aliases["cht"]   = lambda args: print(requests.get("https://cheat.sh/"   + " ".join(args)).text)
aliases["wttr"]  = lambda args: print(requests.get("https://wttr.in/"    + " ".join(args)).text)
aliases["wttr2"] = lambda args: print(requests.get("https://v2.wttr.in/" + " ".join(args)).text)
aliases["rate"]  = lambda args: print(requests.get("https://rate.sx/"    + " ".join(args)).text)

### Rickroll
$roll = "curl -sL 'http://bit.ly/10hA8iC' | bash"
aliases["roll"] = lambda: pyperclip.copy($roll)
aliases["rollout"] = $roll

### Lorem
$lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
aliases["lorem"] = lambda args=[1]: pyperclip.copy("\n".join([$lorem] * int(args[0]))) #FIXME default parameter #TODO lorem word

### Abbrevs
abbrevs["e"] = $EDITOR
abbrevs["g"] = "git"

## Startup --------------------------------------------------------------------

sysfetch()
prompt_hr()
