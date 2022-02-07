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
      historyControl = ["erasedups" "ignorespace"];
      shellAliases = {
        l = "ls --almost-all --group-directories-first";
        dl = "trash-put";
        md = "mkdir --parents";
        ex = "patool extract";
        ar = "patool create";
        e = "$EDITOR";
        g = "git";
      };
      bashrcExtra = ''
        for env in EDITOR VISUAL PAGER MANPAGER; do eval export $env=hx; done
        theme
        export PS1="\[\e]0;\w\a\e[0;90m\] \w [E:\$?]\n\[\033[0;1;94m\]❯\[\e[m\] " #TODO better error display
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
