{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xonsh      # Command shell
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    #helix     # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
  ];

  home.file = {
    ".config/xonsh/rc.xsh".text = ''
      $MULTILINE_PROMPT = "|"
      $PROMPT = "\033[0;3;90m {cwd}\033[0m\n\033[1m{prompt_end} "

      $COMPLETE_DOTS = True
      $DOTGLOB = True
      $AUTO_CD = True

      @events.on_postcommand
      def print_exitcode(cmd, rtn, out, ts, **kw):
        if rtn:
          print(f"\033[7;91m E:{str(rtn)} \033[0m")

      @events.on_chdir
      def auto_ls(olddir, newdir, **kw):
        .


      import os

      $SELECTION = None
      def set_file_select(items):
        $SELECTION = [os.path.abspath(item) for item in items]

      aliases["s"] = lambda args: set_file_select(args)

      aliases["mv"] = lambda args: execx("mv @($SELECTION) .") if not args else execx(" ".join(["mv"] + args))
      aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx(" ".join(["cp -r"] + args))
      aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx(" ".join(["ln -s"] + args))


      aliases["."] = "ls --almost-all --group-directories-firs"
      aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "hx"
      aliases["dl"] = "trash-put"
      aliases["md"] = "mkdir --parents"
      aliases["ex"] = "patool extract"
      aliases["ar"] = "patool create"
      aliases["g"] = "git"

      aliases["n"] = "nohup kitty &>/dev/null &"
      aliases["l"] = lambda args: execx(" ".join(["exec nohup"] + args + [">~/.cache/nohup.out"]))
      aliases["www"] = lambda args: execx(" ".join(["exec nohup chromium"] + args + [">/dev/null"]))

      aliases["bye"] = "systemctl suspend"

      aliases["roll"] = "curl -sL 'https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh' | bash"


      cat "~/.local/share/colorscheme.cat"
    '';
  
    ".local/share/colorscheme.cat".source = builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat";
  };

  programs.git = {
    enable = true;
    userName = "NNB";
    userEmail = "nnbnh@protonmail.com";
    extraConfig = {
      credential.helper = "store";
      include.path = builtins.fetchurl "https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt";
    };
  };
}
