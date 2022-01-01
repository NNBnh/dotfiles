# -*- coding: utf-8 -*-
#    _  __                 __
#   | |/ /___  ____  _____/ /_
#   |   / __ \/ __ \/ ___/ __ \
#  /   / /_/ / / / (__  ) / / /
# /_/|_\____/_/ /_/____/_/ /_/


import os

#FIXME xontrib load hist_navigator


# =============================================================================
# 1. Setting
# =============================================================================

# Display
$MULTILINE_PROMPT  = "|"
$DYNAMIC_CWD_WIDTH = "80%"
$PROMPT            = lambda: "\n\033[0;1;94;40m| {cwd} \033[0;30m▓▒░\n\033[0;1m{prompt_end} "
$TITLE             = lambda: $PWD.replace($HOME, "~") + "/"

# Interactive
$XONSH_AUTOPAIR           = True
$XONSH_CTRL_BKSP_DELETION = True
$COMPLETIONS_DISPLAY      = "single"

# Navigation
$COMPLETE_DOTS = True
$DOTGLOB       = True
$AUTO_CD       = True

# Input method
$GTK_IM_MODULE     = "ibus"
$QT_IM_MODULE      = $GTK_IM_MODULE
$QT4_IM_MODULE     = $GTK_IM_MODULE
$CLUTTER_IM_MODULE = $GTK_IM_MODULE
$GLFW_IM_MODULE    = $GTK_IM_MODULE
$SDL_IM_MODULE     = $GTK_IM_MODULE
$XMODIFIERS        = f"@im={$GTK_IM_MODULE}"

# Paths
$PATH += [f"{$HOME}/.local/bin"]
if os.path.exists(f"{$HOME}/.nix-profile") and not __xonsh__.env.get("NIX_PATH"):
	$NIX_REMOTE           = "daemon"
	$NIX_USER_PROFILE_DIR = f"/nix/var/nix/profiles/per-user/{$HOME}"
	$NIX_PROFILES         = f"/nix/var/nix/profiles/default {$HOME}/.nix-profile"
	$NIX_SSL_CERT_FILE    = "/etc/ssl/certs/ca-certificates.crt"
	$NIX_PATH             = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels"

	$PATH += [f"{$HOME}/.nix-profile/bin", "/nix/var/nix/profiles/default/bin"]

# Editor
$EDITOR   = "hx"
$VISUAL   = $EDITOR
$PAGER    = $EDITOR
$MANPAGER = $EDITOR


# =============================================================================
# 2. Events
# =============================================================================

@events.on_postcommand
def save_command_info(cmd, rtn, out, ts, **kw):
	if rtn:
		print(f"\033[7;38;5;9m E:{str(rtn)} \033[0m")

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	exa --all --group-directories-first


# =============================================================================
# 3. Aliases
# =============================================================================

# File system
aliases["."]  = "exa --all --group-directories-first --long --header --across --git"
aliases["dl"] = "trash-put"
aliases["e"]  = $EDITOR
aliases["md"] = "mkdir --parents"
aliases["ex"] = "patool extract"
aliases["ar"] = "patool create"
aliases["g"]  = "git"
aliases["b"]  = "edir"

# Selection
$SELECTION = None
def set_file_select(items):
	$SELECTION = [os.path.abspath(item) for path in items]
aliases["s"]   = lambda args: set_file_select(args)
aliases["mv"]  = lambda args: execx("mv    @($SELECTION) .") if not args else execx("mv "    + " ".join(args))
aliases["cp"]  = lambda args: execx("cp -r @($SELECTION) .") if not args else execx("cp -r " + " ".join(args))
aliases["ln"]  = lambda args: execx("ln -s @($SELECTION) .") if not args else execx("ln -s " + " ".join(args))
aliases["hln"] = lambda args: execx("ln    @($SELECTION) .") if not args else execx("ln -s " + " ".join(args))

# Services
aliases["cht"]   = lambda args: print(requests.get("https://cheat.sh/" + " ".join(args)).text)
aliases["rate"]  = lambda args: print(requests.get("https://rate.sx/"  + " ".join(args)).text)

# Rickroll
$roll              = "curl -sL 'http://bit.ly/10hA8iC' | bash"
aliases["roll"]    = lambda: pyperclip.copy($roll)
aliases["rollout"] = $roll

# Lorem
$lorem = (
	"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
	"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
	"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
	"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
)

# =============================================================================
# 4. Startup
# =============================================================================

print(
	end="".join(
		[
			"\033[1 q",
			"\033]10;#FFFFFF\033\\",
			"\033]11;#171726\033\\",
			"\033]12;#6BB8FF\033\\",
			"\033]708;#171726\033\\",
		] + [
			f"\033]P{'%X' % index}{color}\007\033]4;{index};#{color}\007"
			for index, color in enumerate(
				[
					"22273D", "DE5D6E", "76A85D", "FF9470", "5890F8", "C173D1", "64B5A7", "878D96",
					"525866", "FA7883", "98C379", "FFC387", "6BB8FF", "E799FF", "8AF5FF", "C8C8C8"
				]
			)
		]
	)
)
