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

aliases["bye"] = "systemctl suspend"

aliases["roll"] = "curl -sL 'https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh' | bash"


# =============================================================================

print(
	end="".join(
		[
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
