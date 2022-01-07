{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
  wallpaper = builtins.fetchurl "https://github.com/NNBnh/wallpapers/raw/main/brown-concrete-house-surrounded-by-plants.jpg";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    # Core
    wayfire             # Windows manager
    brightnessctl       # Brightness control
    slurp               # Region selector
    grim                # Screen shot
    wf-recorder         # Screen record
    sarasa-gothic       # CJK support
    blueberry           # Bluetooth manager

    # Applications
    ungoogled-chromium  # Web browser
    blender             # Graphic editor
    godot               # Game engine
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";

    ".local/share/wallpaper.png".source = wallpaper;
    ".config/wf-shell.ini".text =''
      [background]
      image = /home/nnb/.local/share/wallpaper.png
    '';

    ".config/wayfire.conf".source = ./wayfire.conf;
  };

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
      background_opacity = "0.90";
      dynamic_background_opacity = true;
      disable_ligatures = "cursor";
      clear_all_shortcuts = true;
      allow_remote_control = true;
    };
    keybindings = {
      "super+c" = "copy_to_clipboard";
      "super+v" = "paste_from_clipboard";
      "super+equal" = "change_font_size all +2";
      "super+minus" = "change_font_size all -2";
      "super+0" = "change_font_size all 0";
    };
  };
}
