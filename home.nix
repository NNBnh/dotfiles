{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Core
    qtile                # Windows manager
    brightnessctl        # Screen backlight
    playerctl            # Control media

    # Resource
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

  programs = {
    home-manager.enable = true;

    #FIXME xonsh.enable = true;

    git = {
      enable = true;
      userName  = "NNB";
      userEmail = "nnbnh@protonmail.com";
      extraConfig.credential.helper = "store";
    };

    #FIXME steam.enable = true;
  };

  i18n.inputMethod = { #TODO config
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  home.file = {
    ".config/qtile/config.py".source = ./qtile.py;
    ".config/xonsh/rc.xsh".source = ./rc.xsh;
    ".config/X11/xresources".text = ''
      *.font: Bmono:pixelsize=10.0
      *.alpha: 9.0
    '';
  };
}
