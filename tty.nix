{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xonsh      # Command shell
    exa        # Pretty file list
    helix      # Text editor
    ffmpeg     # Media manipulator
    asciinema  # Record terminal sessions
    figlet     # Text banner generator
    ruby_3_0   # Scripting language
  ];

  home.file.".config/xonsh/rc.xsh".source = ./rc.xsh;

  programs.git = {
    enable = true;
    userName = "NNB";
    userEmail = "nnbnh@protonmail.com";
    extraConfig.credential.helper = "store";
  };
}
