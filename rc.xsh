# -*- coding: utf-8 -*-

import os


$MULTILINE_PROMPT = "|"
$PROMPT = "\n\033[0;1;94m {cwd}\033[0m\n\033[1m{prompt_end} "
$TITLE = "{cwd}"

$XONSH_AUTOPAIR = True
$XONSH_CTRL_BKSP_DELETION = True

$COMPLETE_DOTS = True
$DOTGLOB = True
$AUTO_CD = True

@events.on_postcommand
def print_exitcode(cmd, rtn, out, ts, **kw):
	if rtn:
		print(f"\033[7;91m E:{str(rtn)} \033[0m")

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
	exa --all --group-directories-first


# =============================================================================

$SELECTION = None

def set_file_select(items):
	$SELECTION = [os.path.abspath(item) for item in items]

aliases["s"] = lambda args: set_file_select(args)

aliases["mv"] = lambda args: execx("mv @($SELECTION) .") if not args else execx(" ".join(["mv"] + args))
aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx(" ".join(["cp -r"] + args))
aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx(" ".join(["ln -s"] + args))
aliases["hln"] = lambda args: execx("ln @($SELECTION) .") if not args else execx(" ".join(["ln"] + args))

aliases["."] = "exa --all --group-directories-first --long --header --across --git"
aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "hx"
aliases["dl"] = "trash-put"
aliases["md"] = "mkdir --parents"
aliases["ex"] = "patool extract"
aliases["ar"] = "patool create"
aliases["b"] = "edir"
aliases["g"] = "git"

aliases["n"] = "nohup kitty &>/dev/null &"
aliases["l"] = lambda args: execx(" ".join(["exec nohup"] + args + [">~/.cache/nohup.out"]))
aliases["www"] = lambda args: execx(" ".join(["exec nohup chromium"] + args + [">/dev/null"]))

aliases["bye"] = "systemctl suspend"

aliases["roll"] = "curl -sL 'https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh' | bash"


# =============================================================================

cat "~/.local/share/colorscheme.cat"
