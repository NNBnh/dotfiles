# -*- coding: utf-8 -*-
#    _  __                 __
#   | |/ /___  ____  _____/ /_
#   |   / __ \/ __ \/ ___/ __ \
#  /   / /_/ / / / (__  ) / / /
# /_/|_\____/_/ /_/____/_/ /_/


import os, re, datetime, importlib

#if not importlib.util.find_spec("edir"):
#	os.system("python -m pip install xonsh[full] xontrib-hist_navigator edir patool trash-cli")

xontrib load hist_navigator


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

## Default Applications -------------------------------------------------------

$EDITOR   = "hx"
$VISUAL   = $EDITOR
$PAGER    = $EDITOR
$MANPAGER = $EDITOR

$TERMINAL = "st"
$BROWSER  = "brave"

## Bfetch Setting -------------------------------------------------------------

$BFETCH_INFO  = f"{$HOME}/c/ricefetch"
$BFETCH_ART   = "cat \"$HOME/.local/share/ansi/arch.ansi\""
$BFETCH_COLOR = "color-strip \"\\033[7m   \""

$BFETCH_PROMPT_HEIGHT = 2

## Xonsh Setting --------------------------------------------------------------

# Display
$MULTILINE_PROMPT = "░"
$PROMPT           = lambda: "\033[1;7;37m " + datetime.datetime.now().strftime("%H:%M") + " \033[0m "
$TITLE            = lambda: $PWD.replace($HOME, "~")

# Navigation
$COMPLETE_DOTS = True
$DOTGLOB       = True
$AUTO_CD       = True
$XONTRIB_ONEPATH_ACTIONS = {
	"text/":   $EDITOR,
	"<FILE>":  "xdg-open",
	"<XFILE>": "<RUN>"
}

### Interactive
$IGNOREEOF                = True
$XONSH_AUTOPAIR           = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_DISPLAY      = "single"


# =============================================================================
# 2. Function
# =============================================================================

def hr(string="#"):
	print("\033[?7l" + string * os.get_terminal_size().columns + "\033[?7h")

$SELECTION = None
def set_file_select(paths):
	$SELECTION = [os.path.abspath(path) for path in paths]

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	exa --all --group-directories-first

@events.on_postcommand
def command_info(cmd, rtn, out, ts, **kw):
	info_string = ""

	if rtn != 0:
		info_string += " \033[38;5;9mE:" + str(rtn)

	duration = ts[1] - ts[0]
	if duration >= 2:
		info_string += " \033[38;5;8mtook \033[38;5;11m"

		if duration >= 60:
			info_string += str(datetime.timedelta(seconds = round(duration)))
		else:
			info_string += "{:.3f}s".format(duration)

	print(end="\033[38;5;8m")
	hr("_")
	print(end="\033[0m")

	if info_string:
		print("\033[A\033[" + str(os.get_terminal_size().columns - len(re.sub("\\033\\[[0-9;]*[JKmsu]", "", info_string)) - 1) + f"C{info_string} ")

# =============================================================================
# 3. Aliases
# =============================================================================

# Display
aliases["hr"] = lambda args=["#"]: [hr(string) for string in args] #FIXME default parameter

# File system
aliases["."]  = "exa --all --group-directories-first --long --header --across --git"
aliases["dl"] = "trash-put"
aliases["e"]  = $EDITOR
aliases["md"] = "mkdir --parents"
aliases["ex"] = "patool extract"
aliases["ar"] = "patool create"
aliases["b"]  = "edir"

# Selection
aliases["s"]  = lambda args: set_file_select(args)
aliases["mv"] = lambda args: execx("mv @($SELECTION) ."   ) if not args else execx("mv "    + " ".join(args))
aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx("cp -r " + " ".join(args))
aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx("ln -s " + " ".join(args))

# Git
aliases["g"]   = "git"
aliases["ga"]  = "git add -A"
aliases["gc"]  = "git commit -m"
aliases["get"] = "git fetch --prune && git pull --rebase && git submodule update --init --recursive"
aliases["put"] = "git commit --all && git push"

# Services
aliases["cht"]   = lambda args: print(requests.get("https://cheat.sh/"   + " ".join(args)).text)
aliases["wttr"]  = lambda args: print(requests.get("https://wttr.in/"    + " ".join(args)).text)
aliases["wttr2"] = lambda args: print(requests.get("https://v2.wttr.in/" + " ".join(args)).text)
aliases["rate"]  = lambda args: print(requests.get("https://rate.sx/"    + " ".join(args)).text)

# Rickroll
$roll              = "curl -sL 'http://bit.ly/10hA8iC' | bash"
aliases["roll"]    = lambda: pyperclip.copy($roll)
aliases["rollout"] = $roll

# Lorem
$lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
aliases["lorem"] = lambda args=[1]: pyperclip.copy("\n".join([$lorem] * int(args[0]))) #FIXME default parameter #TODO lorem word
