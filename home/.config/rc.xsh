#!/bin/python3
# -*- coding: utf-8 -*-

import os, platform, requests, datetime, pyperclip
xontrib load abbrevs


XDG_CONFIG_HOME = "$HOME/.config"
XDG_CACHE_HOME = "$HOME/.cache"
XDG_DATA_HOME = "$HOME/.local/share"

XDG_DESKTOP_DIR = "$HOME/t"
XDG_DOCUMENTS_DIR = "$XDG_DESKTOP_DIR"
XDG_DOWNLOAD_DIR = "$XDG_DESKTOP_DIR"
XDG_MUSIC_DIR = "$HOME/d/music"
XDG_PICTURES_DIR = "$XDG_DESKTOP_DIR"
XDG_PUBLICSHARE_DIR = "$XDG_DESKTOP_DIR"
XDG_TEMPLATES_DIR = "$XDG_DESKTOP_DIR"
XDG_VIDEOS_DIR = "$XDG_DESKTOP_DIR"

# XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority"
USERXSESSION = "$XDG_CACHE_HOME/x11/xsession"
USERXSESSIONRC = "$XDG_CACHE_HOME/x11/xsessionrc"
ALTUSERXSESSION = "$XDG_CACHE_HOME/x11/Xsession"
ERRFILE = "$XDG_CACHE_HOME/x11/xsession-errors"
XINITRC = "$XDG_CONFIG_HOME/X11/xinitrc"
XSERVERRC = "$XDG_CONFIG_HOME/X11/xserverrc"
ICEAUTHORITY = "$XDG_CACHE_HOME/ICEauthority"
INPUTRC = "$XDG_CONFIG_HOME/readline/inputrc"
GNUPGHOME = "$XDG_DATA_HOME/gnupg"
HISTFILE = "$XDG_DATA_HOME/shell/history"
CARGO_HOME = "$XDG_DATA_HOME/cargo"
GTK_RC_FILES = "$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

EDITOR = "kak"
VISUAL = EDITOR
PAGER = EDITOR
MANPAGER = EDITOR
TERMINAL = "bt"
BROWSER = "firefox"

MOZ_ENABLE_WAYLAND = "1"

GTK_IM_MODULE = "fcitx"
QT_IM_MODULE = "fcitx"
SDL_IM_MODULE = "fcitx"
XMODIFIERS = "@im=fcitx"

CODERUN_ = "chmod +x \$FULL && \$FULL"
CODERUN_sh = "$CODERUN_"
CODERUN_bash = "bash \$FULL"
CODERUN_zsh = "zsh \$FULL"
CODERUN_fish = "fish \$FULL"
CODERUN_1 = "man \$FULL"
CODERUN_2 = "$CODERUN_1"
CODERUN_3 = "$CODERUN_1"
CODERUN_4 = "$CODERUN_1"
CODERUN_5 = "$CODERUN_1"
CODERUN_6 = "$CODERUN_1"
CODERUN_7 = "$CODERUN_1"
CODERUN_8 = "$CODERUN_1"
CODERUN_9 = "$CODERUN_1"
CODERUN_js = "node \$FULL"
CODERUN_cjs = "$CODERUN_js"
CODERUN_mjs = "$CODERUN_js"
CODERUN_java = "cd \$DIRECTORY && javac \$FILE && java \$NAME"
CODERUN_class = "$CODERUN_java"
CODERUN_jar = "$CODERUN_java"
CODERUN_c = "cd \$DIRECTORY && gcc -lm \$FILE -o \$NAME && \$DIRECTORY/\$NAME"
CODERUN_h = "$CODERUN_c"
CODERUN_cc = "cd \$DIRECTORY && g++ -lm \$FILE -o \$NAME && \$DIRECTORY/\$NAME"
CODERUN_C = "$CODERUN_cc"
CODERUN_cpp = "$CODERUN_cc"
CODERUN_cxx = "$CODERUN_cc"
CODERUN_hh = "$CODERUN_cc"
CODERUN_H = "$CODERUN_cc"
CODERUN_hpp = "$CODERUN_cc"
CODERUN_hxx = "$CODERUN_cc"
CODERUN_m = "cd \$DIRECTORY && gcc -framework Cocoa \$FILE -o \$NAME && \$DIRECTORY/\$NAME"
CODERUN_mm = "$CODERUN_m"
CODERUN_M = "$CODERUN_m"
CODERUN_php = "php \$FULL"
CODERUN_phtml = "$CODERUN_php"
CODERUN_php3 = "$CODERUN_php"
CODERUN_php4 = "$CODERUN_php"
CODERUN_php5 = "$CODERUN_php"
CODERUN_php7 = "$CODERUN_php"
CODERUN_phps = "$CODERUN_php"
CODERUN_php_s = "$CODERUN_php"
CODERUN_pht = "$CODERUN_php"
CODERUN_phar = "$CODERUN_php"
CODERUN_py = "python -u \$FULL"
CODERUN_pyi = "$CODERUN_py"
CODERUN_pyc = "$CODERUN_py"
CODERUN_pyd = "$CODERUN_py"
CODERUN_pyo = "$CODERUN_py"
CODERUN_pyw = "$CODERUN_py"
CODERUN_pyz = "$CODERUN_py"
CODERUN_perl = "perl \$FULL"
CODERUN_plx = "$CODERUN_perl"
CODERUN_pl = "$CODERUN_perl"
CODERUN_pm = "$CODERUN_perl"
CODERUN_xs = "$CODERUN_perl"
CODERUN_t = "$CODERUN_perl"
CODERUN_pod = "$CODERUN_perl"
CODERUN_rb = "ruby \$FULL"
CODERUN_go = "go run \$FULL"
CODERUN_gccgo = "$CODERUN_go"
CODERUN_lua = "lua \$FULL"
CODERUN_groovy = "groovy \$FULL"
CODERUN_gvy = "$CODERUN_groovy"
CODERUN_gy = "$CODERUN_groovy"
CODERUN_gsh = "$CODERUN_groovy"
CODERUN_ps1 = "powershell -ExecutionPolicy ByPass -File \$FULL"
CODERUN_ps1xml = "$CODERUN_ps1"
CODERUN_psc1 = "$CODERUN_ps1"
CODERUN_psd1 = "$CODERUN_ps1"
CODERUN_psm1 = "$CODERUN_ps1"
CODERUN_pssc = "$CODERUN_ps1"
CODERUN_psrc = "$CODERUN_ps1"
CODERUN_cdxml = "$CODERUN_ps1"
CODERUN_cmd = "cmd /c \$FULL"
CODERUN_bat = "$CODERUN_cmd"
CODERUN_btm = "$CODERUN_cmd"
CODERUN_fsi = "fsi \$FULL"
CODERUN_fs = "$CODERUN_fsi"
CODERUN_fsx = "$CODERUN_fsi"
CODERUN_fsscript = "$CODERUN_fsi"
CODERUN_cs = "scriptcs \$FULL"
CODERUN_csx = "$CODERUN_cs"
CODERUN_vbs = "cscript //Nologo \$FULL"
CODERUN_vbe = "$CODERUN_vbs"
CODERUN_wsf = "$CODERUN_vbs"
CODERUN_wsc = "$CODERUN_vbs"
CODERUN_ts = "ts-node \$FULL"
CODERUN_tsx = "$CODERUN_ts"
CODERUN_coffee = "coffee \$FULL"
CODERUN_litcoffee = "$CODERUN_coffee"
CODERUN_scala = "scala \$FULL"
CODERUN_sc = "$CODERUN_scala"
CODERUN_swift = "swift \$FULL"
CODERUN_jl = "julia \$FULL"
CODERUN_cr = "crystal \$FULL"
CODERUN_ml = "ocaml \$FULL"
CODERUN_mli = "$CODERUN_ml"
CODERUN_r = "Rscript \$FULL"
CODERUN_rdata = "$CODERUN_r"
CODERUN_rds = "$CODERUN_r"
CODERUN_rda = "$CODERUN_r"
CODERUN_scpt = "osascript \$FULL"
CODERUN_scptd = "$CODERUN_scpt"
CODERUN_applescript = "$CODERUN_scpt"
CODERUN_clj = "lein exec \$FULL"
CODERUN_cljs = "$CODERUN_clj"
CODERUN_cljc = "$CODERUN_clj"
CODERUN_edn = "$CODERUN_clj"
CODERUN_hx = "haxe --cwd \$DIRECTORY --run \$NAME"
CODERUN_hxml = "$CODERUN_hx"
CODERUN_rs = "cd \$DIRECTORY && rustc \$FILE && \$DIRECTORY/\$NAME"
CODERUN_rlib = "$CODERUN_rs"
CODERUN_rkt = "racket \$FULL"
CODERUN_scm = "csi -script \$FULL"
CODERUN_ss = "$CODERUN_scm"
CODERUN_ahk = "autohotkey \$FULL"
CODERUN_au3 = "autoit3 \$FULL"
CODERUN_dart = "dart \$FULL"
CODERUN_pp = "cd \$DIRECTORY && fpc \$FILE && \$DIRECTORY/\$NAME"
CODERUN_pas = "$CODERUN_pp"
CODERUN_inc = "$CODERUN_pp"
CODERUN_d = "cd \$DIRECTORY && dmd \$FILE && \$DIRECTORY/\$NAME"
CODERUN_hs = "runhaskell \$FULL"
CODERUN_lhs = "$CODERUN_hs"
CODERUN_nim = "nim compile --verbosity:0 --hints:off --run \$FULL"
CODERUN_nims = "$CODERUN_nim"
CODERUN_nimbls = "$CODERUN_nim"
CODERUN_lisp = "sbcl --script \$FULL"
CODERUN_kit = "kitc --run \$FULL"
CODERUN_v = "v run \$FULL"
CODERUN_sass = "sass --style expanded \$FULL"
CODERUN_scss = "scss --style expanded \$FULL"
CODERUN_less = "cd \$DIRECTORY && lessc \$FILE \$NAME.css"
CODERUN_f = "cd \$DIRECTORY && gfortran \$FILE -o \$NAME && \$DIRECTORY/\$NAME"
CODERUN_for = "$CODERUN_f"
CODERUN_f90 = "$CODERUN_f"

abbrevs["o"] = "xdg-open"
abbrevs["e"] = "$EDITOR"
abbrevs["g"] = "git"
abbrevs["music_dl"]  = "youtube-dl --add-metadata --embed-thumbnail --audio-format 'mp3'"

def _roll():
	"Reload the Rickroll"
	pyperclip.copy("curl -sL 'http://bit.ly/10hA8iC' | bash")
aliases["roll"] = "_roll()"

def _ifjson(): #TODO
	"ifconfig.co/json"
	print(requests.get("https://ifconfig.co/json").text)
aliases["ifjson"] = "_ifjson()"

def _cht(arg):
	"cheat.sh"
	print(requests.get("https://cheat.sh/" + str(arg)).text)
aliases["cht"] = "_cht()"

def _wttr(arg):
	"wttr.in"
	print(requests.get("https://wttr.in/" + str(arg)).text)
aliases["wttr"] = "_wttr()"

def _wttr2(arg):
	"v2.wttr.in"
	print(requests.get("https://v2.wttr.in/" + str(arg)).text)
aliases["wttr2"] = "_wttr2()"

def _rate(arg):
	"rate.sx"
	print(requests.get("https://rate.sx/" + str(arg)).text)
aliases["rate"] = "_rate()"

def _sysfetch():
	elements = ["os", "wm", "shell", "terminal", "font"]
	pad = len(max(elements, key = len))
	infos = {
		"os": platform.system() + " " + platform.release(), #TODO
		"wm": "Sway", #TODO
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

def _diyship(): #TODO
	duration = os.environ.get("DIYSHIP_DURATION")
	status   = os.environ.get("DIYSHIP_STATUS")

	if duration >= 2000:
		datetime.timedelta(milliseconds = duration)

	if status >= 0:
		if status == "126":
			STATUS_SYMBOL = "🚫"
		if status == "127":
			STATUS_SYMBOL = "🔍"
		if status == "130":
			STATUS_SYMBOL = "🧱"
		else:
			STATUS_SYMBOL = "⚡"

	if os.path.exists(os.getcwd() + "/.git"):
		# GIT_BRANCH=$(git rev-parse --abbrev-ref 'HEAD' 2>/dev/null) \
		# && GIT_BRANCH="on \033[1;95m $GIT_BRANCH"

		# git symbolic-ref 'HEAD' 2>&1 >/dev/null || {
		# 	GIT_HASH=$(git rev-parse --verify --short 'HEAD' 2>/dev/null) \
		# 	&& GIT_HASH="\033[1;92m#$GIT_HASH"
		# }

		# GIT_TAG=$(git tag --points-at 'HEAD' 2>/dev/null) \
		# && [ -n "$GIT_TAG" ] && GIT_TAG="\033[1;93m🏷 $GIT_TAG"
		pass

	CWD  = os.getcwd()
	HOME = os.path.expanduser("~")
	if   CWD == HOME + "d/":
		CWD_SYMBOL = "🗃 "
	elif CWD == HOME + "c/":
		CWD_SYMBOL = "⚙ "
	elif CWD == HOME + "t/":
		CWD_SYMBOL = "⚗ "
	elif CWD == HOME:
		CWD_SYMBOL = "🏠"
	elif CWD == HOME:
		CWD_SYMBOL = "📂"
	else:
		CWD_SYMBOL = "📁"


# stty intr '^X' susp '^P' eof '^Q' start '^A' stop '^E' -echo
# bfetch
# bui-terminal
