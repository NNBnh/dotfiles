{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; (
    with (import <unstable> {}); [ helix ]
  ) ++ [
    xonsh trash-cli patool edir ffmpeg
    (pkgs.writeScriptBin "theme" "cat ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat"}")
  ];

  home.file.".config/xonsh/rc.xsh".text = ''
    theme

    $TITLE = "{cwd}"
    $PROMPT = "\033[0;1;90m {cwd}\033[0m\n\033[1;94m❯ "
    $MULTILINE_PROMPT = "|"
    $XONSH_AUTOPAIR = $XONSH_CTRL_BKSP_DELETION = $COMPLETE_DOTS = $DOTGLOB = $AUTO_CD = True

    aliases["."] = "ls --almost-all --group-directories-first"
    aliases["icat"] = "kitty +kitten icat"
    aliases["dl"] = "trash-put"
    aliases["md"] = "mkdir --parents"
    aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "hx"
    aliases["g"] = "git"

    @events.on_postcommand
    def print_exitcode(cmd, rtn, out, ts, **kw):
      if rtn:
        print(f"\033[7;91m E:{str(rtn)} \033[0m")

    @events.on_chdir
    def auto_ls(olddir, newdir, **kw):
      .
  '';

  programs = {
    bash = {
      enable = true;
      historyFile = ".cache/bash_history";
      initExtra = "[ -z $XONSH_AUTOPAIR ] && exec xonsh";
    };

    git = {
      enable = true;
      userName = "NNB";
      userEmail = "nnbnh@protonmail.com";
      extraConfig = {
        credential.helper = "store";
        include.path = builtins.fetchurl "https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt";
      };
    };
  };
}
