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
    krita               # Image editor
    blender             # Motion graphics
    godot               # Game engine

    # Games
    retroarch           # Retro emulators
    multimc             # Minecraft launcher
    osu-lazer           # Rhythm game
  ];

  home.file.".config/qtile/config.py".source = ./qtile.py;

  services.picom = {
    enable = true;
    blur = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Bmono";
      size = 10;
    };
    settings = {
      background_opacity = "0.75";
      dynamic_background_opacity = true;
      disable_ligatures = "cursor";
      clear_all_shortcuts = true;
    };
    keybindings = {
      "ctrl+equal" = "change_font_size all +2";
      "ctrl+minus" = "change_font_size all -2";
      "ctrl+0" = "change_font_size all 0";
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [ "cjpalhdlnbpafiamejdnhcphjbkeiagm" ]; #FIXME
  };
}
