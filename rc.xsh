# -*- coding: utf-8 -*-
#    _  __                 __
#   | |/ /___  ____  _____/ /_
#   |   / __ \/ __ \/ ___/ __ \
#  /   / /_/ / / / (__  ) / / /
# /_/|_\____/_/ /_/____/_/ /_/


import os, re, datetime, importlib

#TODO xontrib-hist_navigator trash-cli patool edir
#FIXME xontrib load hist_navigator


# =============================================================================
# 1. Function
# =============================================================================

$SELECTION = None
def set_file_select(paths):
	$SELECTION = [os.path.abspath(path) for path in paths]

def hr(string="#"):
	print("\033[?7l" + string * os.get_terminal_size().columns + "\033[?7h")

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
		print(
			"\033[A\033[" + str(
				os.get_terminal_size().columns
				- len(re.sub("\\033\\[[0-9;]*[JKmsu]", "", info_string))
				- 1
			) + f"C{info_string} "
		)

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	exa --all --group-directories-first


# =============================================================================
# 2. Setting
# =============================================================================

# Display
$MULTILINE_PROMPT  = "░"
$DYNAMIC_CWD_WIDTH = "25%"
$PROMPT            = lambda: "\033[0;1;7;37m {cwd} \033[0m "
$TITLE             = lambda: $PWD.replace($HOME, "~") + "/"

# Interactive
$IGNOREEOF                = True
$XONSH_AUTOPAIR           = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_DISPLAY      = "single"

# Navigation
$COMPLETE_DOTS = True
$DOTGLOB       = True
$AUTO_CD       = True

# Input method
$GTK_IM_MODULE = "fcitx"
$QT_IM_MODULE  = $GTK_IM_MODULE
$SDL_IM_MODULE = $GTK_IM_MODULE
$XMODIFIERS    = f"@im={$GTK_IM_MODULE}"

# Paths
$PATH += [f"{$HOME}/.local/bin"]
if os.path.exists(f"{$HOME}/.nix-profile") and not __xonsh__.env.get("NIX_PATH"):
	$NIX_REMOTE           = "daemon"
	$NIX_USER_PROFILE_DIR = f"/nix/var/nix/profiles/per-user/{$HOME}"
	$NIX_PROFILES         = f"/nix/var/nix/profiles/default {$HOME}/.nix-profile"
	$NIX_SSL_CERT_FILE    = "/etc/ssl/certs/ca-certificates.crt"
	$NIX_PATH             = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"

	$PATH += [f"{$HOME}/.nix-profile/bin", "/nix/var/nix/profiles/default/bin"]

## Applications
$EDITOR   = "hx"
$VISUAL   = $EDITOR
$PAGER    = $EDITOR
$MANPAGER = $EDITOR
$TERMINAL = "st"
$BROWSER  = "brave"

# SuperB Fetch
$BFETCH_INFO  = f"{$HOME}/c/ricefetch"
$BFETCH_ART   = "cat \"$HOME/.local/share/ansi/arch.ansi\""
$BFETCH_COLOR = "color-strip \"\\033[7m   \""
$BFETCH_PROMPT_HEIGHT = 2


# =============================================================================
# 3. Aliases
# =============================================================================

### Display
aliases["hr"] = lambda args=["#"]: [hr(string) for string in args] #FIXME default parameter

### File system
aliases["."]  = "exa --all --group-directories-first --long --header --across --git"
aliases["dl"] = "trash-put"
aliases["e"]  = $EDITOR
aliases["md"] = "mkdir --parents"
aliases["ex"] = "patool extract"
aliases["ar"] = "patool create"
aliases["b"]  = "edir"

### Selection
aliases["s"]  = lambda args: set_file_select(args)
aliases["mv"] = lambda args: execx("mv @($SELECTION) ."   ) if not args else execx("mv "    + " ".join(args))
aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx("cp -r " + " ".join(args))
aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx("ln -s " + " ".join(args))

### Git
aliases["g"]   = "git"
aliases["ga"]  = "git add -A"
aliases["gc"]  = "git commit -m"
aliases["get"] = "git fetch --prune && git pull --rebase && git submodule update --init --recursive"
aliases["put"] = "git commit --all && git push"

### Services
aliases["cht"]   = lambda args: print(requests.get("https://cheat.sh/"   + " ".join(args)).text)
aliases["wttr"]  = lambda args: print(requests.get("https://wttr.in/"    + " ".join(args)).text)
aliases["wttr2"] = lambda args: print(requests.get("https://v2.wttr.in/" + " ".join(args)).text)
aliases["rate"]  = lambda args: print(requests.get("https://rate.sx/"    + " ".join(args)).text)

### Rickroll
$roll              = "curl -sL 'http://bit.ly/10hA8iC' | bash"
aliases["roll"]    = lambda: pyperclip.copy($roll)
aliases["rollout"] = $roll

### Lorem
$lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
aliases["lorem"] = lambda args=[1]: pyperclip.copy("\n".join([$lorem] * int(args[0]))) #FIXME default parameter #TODO lorem word


# =============================================================================
# 4. Startup
# =============================================================================

print(
	end="".join(
		[
			"\033[0 q",
			"\033]10;#FFFFFF\033\\",
			"\033]11;#171726\033\\",
			"\033]12;#6BB8FF\033\\",
			"\033]708;#171726\033\\",
		] + [
			f"\033]P{'%X' % index}{color}\033]4;{index};#{color}\033\\"
			for index, color in enumerate(
				[
					"22273D",
					"DE5D6E",
					"76A85D",
					"FF9470",
					"5890F8",
					"C173D1",
					"64B5A7",
					"878D96",
					"525866",
					"FA7883",
					"98C379",
					"FFC387",
					"6BB8FF",
					"E799FF",
					"8AF5FF",
					"C8C8C8"
				]
			)
		]
	)
)

#TODO bfetch
