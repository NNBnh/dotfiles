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

  programs.kitty = {
    enable = true;
    font = {
      name = "Bmono";
      size = 10;
    };
    settings = {
      background_opacity = 0.9;
      allow_remote_control = true;
      dynamic_background_opacity = true;
      disable_ligatures = "cursor";
      url_style = false;
      kitty_mod = "ctrl+shift";
      clear_all_shortcuts = true;
      terminal_select_modifiers = "shift";
      open_url_modifiers = "kitty_mod";
    };
    keybindings = {
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";
      "ctrl+equal" = "change_font_size all +2";
      "ctrl+minus" = "change_font_size all -2";
      "ctrl+apostrophe" = "change_font_size all 0";
    };
  };
}
