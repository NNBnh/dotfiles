{ config, pkgs, ... }:

{
  #home.username = "$USER";
  #home.homeDirectory = "$HOME";

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Utilitie
    brightnessctl        # Screen backlight
    playerctl            # Control media
    dunst                # Notification daemon

    # Resource
    #bmono               # Mono font
    sarasa-gothic        # Non Latin support for font
    twemoji-color-font   # Emoji support for font
    bibata-cursors       # Cursor theme

    # Terminal
    #superb-st           # Terminal emulator
    helix                # Text editor
    git                  # Version control system
    ffmpeg               # Media manipulator
    asciinema            # Record terminal sessions
    figlet               # Text banner generator
    nms                  # Hacker mode

    # Programming
    ruby_3_0             # Scripting language
    crystal              # Compiled language

    # Applications
    brave                # Browser
    krita                # Image editor
    blender              # Motion graphics
    godot                # Game engine

    # Games
    retroarch            # Retro emulators
    multimc              # Minecraft launcher
    osu-lazer            # Rhythm game
  ];

  programs = {
    home-manager.enable = true;

    #xonsh.enable = true;

    git = {
      enable = true;
      userName  = "NNB";
      userEmail = "nnbnh@protonmail.com";
      extraConfig.credential.helper = "store";
    };

    #steam.enable = true;
  };

  home.file = {
    ".config/xonsh/rc.xsh".source = ./rc.xsh;
    ".config/qtile/config.py".source = ./qtile.py;
  };
}
