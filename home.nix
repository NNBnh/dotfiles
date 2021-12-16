{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Core
    qtile                # Windows manager
    #bmono               # Mono font
    sarasa-gothic        # Non Latin support for font
    twemoji-color-font   # Emoji support for font
    bibata-cursors       # Cursor theme

    # Terminal
    #superb-st           # Terminal emulator
    helix                # Text editor
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

  programs.git = {
    enable = true;
    userName  = "NNB";
    userEmail = "nnbnh@protonmail.com";
    extraConfig.credential.helper = "store";
  };

  i18n.inputMethod = { #TODO config
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  xresources = {
    properties = {
      "*.font" = "Bmono:pixelsize=10.0";
      "*.alpha" = 9;
    };
    path = ".config/X11/xresources";
  };

  home.file = {
    ".config/qtile/config.py".source = ./qtile.py;
    ".config/xonsh/rc.xsh".source = ./rc.xsh;
  };
}
