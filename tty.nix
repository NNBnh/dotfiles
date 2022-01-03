{ config, pkgs, ... }:

let
  git-alias = builtins.fetchTarball "https://github.com/GitAlias/gitalias/archive/main.tar.gz";
in {
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xonsh      # Command shell
    exa        # Pretty file list
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    helix      # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
  ];

  home.file.".config/xonsh/rc.xsh".source = ./rc.xsh;

  programs.git = {
    enable = true;
    userName = "NNB";
    userEmail = "nnbnh@protonmail.com";
    extraConfig = {
      credential.helper = "store";
      include.path = "${git-alias}/gitalias.txt";
    };
  };
}
