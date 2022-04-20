{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz") { inherit pkgs; };
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs; };
    };
  };


  home.packages = with pkgs; [
    ruby_3_0 xonsh trash-cli p7zip edir ffmpeg nur.repos.nnb.pepper-lsp
    (pkgs.writeScriptBin "theme" "cat ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-sea.cat"}")
  ];


  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.cacheHome}/bash_history";
    initExtra = "[ -z $XONSH_AUTOPAIR ] && exec xonsh";
  };

  xdg = {
    enable = true;

    configFile."xonsh/rc.xsh".text = ''
      theme

      $TITLE = "{cwd}"
      $PROMPT = "\033[0;1;90m {cwd}\033[0m\n\033[1;94m❯ "
      $MULTILINE_PROMPT = "|"
      $XONSH_AUTOPAIR = $XONSH_CTRL_BKSP_DELETION = $COMPLETE_DOTS = $DOTGLOB = $AUTO_CD = True

      aliases["."] = "ls --almost-all --group-directories-first"
      aliases["dl"] = "trash-put"
      aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "pepper"
      aliases["g"] = "git"

      @events.on_postcommand
      def print_exitcode(cmd, rtn, out, ts, **kw):
        if rtn:
          print(f"\033[7;91m E:{str(rtn)} \033[0m")

      @events.on_chdir
      def auto_ls(olddir, newdir, **kw):
        .
    '';
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
