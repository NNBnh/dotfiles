{ config, pkgs, ... }:

let
  git-alias = pkgs.fetchFromGitHub { #TODO move to Flakes
    owner = "GitAlias";
    repo = "gitalias";
    rev = "38f82c9ff8d70032e21e61779846545df6986dba";
    sha256 = "0j577nfyr97spv186rab8i992c8rjv93zq02kz06i4q3crznpm6j";
  };
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
    figlet     # Text banner generator
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
