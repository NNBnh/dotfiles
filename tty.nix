{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    helix      # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
    (pkgs.writeScriptBin "theme" "cat ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat"}")
  ];

  home.file.".config/helix/config.toml".text = ''
    theme = "base16_terminal"

    [editor]
    line-number = "relative"
  '';

  programs = {
    bash = {
      enable = true;
      historyFile = ".cache/bash_history";
      bash_history = ["erasedups", "ignorespace"];
      shellAliases = {
        l = "ls --almost-all --group-directories-first";
        dl = "trash-put";
        md = "mkdir --parents";
        ex = "patool extract";
        ar = "patool create";
        e = "hx";
        g = "git";
      };
      bashrcExtra = ''
        for env in EDITOR VISUAL PAGER MANPAGER; do eval export $env=hx; done
        theme
        export PS1="\e]0;\w\a\e[0;90m \w\e[0m\n\033[1;94m❯ "
        d() { cd $@; l }

        # @events.on_postcommand
        # def print_exitcode(cmd, rtn, out, ts, **kw):
        #   if rtn:
        #     print(f"\033[7;91m E:{str(rtn)} \033[0m")
      '';
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
