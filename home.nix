{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    # Core
    wayfire             # Windows manager
    swaybg              # Set wallpaper
    pamixer             # Audio control
    brightnessctl       # Brightness control
    slurp               # Region selector
    grim                # Screen shot
    wf-recorder         # Screen record

    # Resource
    sarasa-gothic       # CJK support
    twemoji-color-font  # Emoji support
    bibata-cursors      # Cursor theme

    # Applications
    ungoogled-chromium  # Web browser
    blender             # Graphic editor
    godot               # Game engine
  ];

  home.file.".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";

  home.file.".config/wayfire.conf".source = ./wayfire.conf;

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
