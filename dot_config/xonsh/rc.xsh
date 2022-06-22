import os

$PROMPT = "\n\033[0;1;90m {cwd}\033[0m\n\033[1;94m❯ "
$MULTILINE_PROMPT = "|"
$XONSH_AUTOPAIR = $XONSH_CTRL_BKSP_DELETION = $COMPLETE_DOTS = $DOTGLOB = $AUTO_CD = True

$PAGER = "page -q 90000"
$MANPAGER = "page -C -e 'au User PageDisconnect sleep 100m|%y p|enew! |bd! #|pu p|set ft=man'"

@events.on_postcommand
def print_exitcode(cmd, rtn, out, ts, **kw):
  if rtn:
    print(f"\033[7;91m E:{str(rtn)} \033[0m")

@events.on_chdir
def auto_ls(olddir, newdir, **kw):
  .

$SELECTION = None
def set_file_select(items):
  $SELECTION = [os.path.abspath(item) for item in items]

aliases["."] = "ls --almost-all --group-directories-first"
aliases["dl"] = "trash-put"
aliases["e"] = $EDITOR = $VISUAL = "nvim"
aliases["g"] = "git"
aliases["s"] = lambda args: set_file_select(args)
aliases["mv"] = lambda args: execx("mv    @($SELECTION) .") if not args else execx(" ".join(["mv"]    + args))
aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx(" ".join(["cp -r"] + args))
aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx(" ".join(["ln -s"] + args))
aliases["theme"] = "cat ~/.local/share/theme.cat"

theme
