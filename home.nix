{ config, pkgs, ... }:

{
  imports = [ ./terminal.nix ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # Core
    qtile               # Windows manager
    #bmono              # Mono font
    sarasa-gothic       # Non Latin support for font
    twemoji-color-font  # Emoji support for font
    bibata-cursors      # Cursor theme

    # Applications
    #superb-st          # Terminal emulator
    brave               # Browser
    krita               # Image editor
    blender             # Motion graphics
    godot               # Game engine

    # Games
    retroarch           # Retro emulators
    multimc             # Minecraft launcher
    osu-lazer           # Rhythm game
  ];

  home.file.".config/qtile/config.py".source = ./qtile.py;

  i18n.inputMethod = {
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
}
