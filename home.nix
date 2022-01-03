{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    # Core
    qtile               # Windows manager
    sarasa-gothic       # CJK support
    twemoji-color-font  # Emoji support
    bibata-cursors      # Cursor theme

    # Applications
    ungoogled-chromium  # Web browser
    blender             # Graphic editor
    godot               # Game engine
  ];

  home.file.".config/qtile/config.py".source = ./qtile.py;

  services.picom = {
    enable = true;
    experimentalBackends = true;
    blur = true;
    extraOptions = ''
      blur: {
        method = "dual_kawase";
        strength = 7;
        kern = "3x3box";
      }
    '';
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
      allow_remote_control = true;
    };
    keybindings = {
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";
      "ctrl+equal" = "change_font_size all +2";
      "ctrl+minus" = "change_font_size all -2";
      "ctrl+0" = "change_font_size all 0";
    };
  };
}
