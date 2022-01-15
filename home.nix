{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
  wallpaper = builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/wallpapers/main/brown-concrete-house-surrounded-by-plants.jpg";
  bye = pkgs.writeScriptBin "bye" "echo 'Bye~'; systemctl suspend";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    berry               # Windows manager
    bye                 # Go to sleep
    brightnessctl       # Brightness control
    sarasa-gothic       # CJK support
    ungoogled-chromium  # Web browser
    blender             # Graphic editor
    godot               # Game engine
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";
    ".config/berry/autostart".text = ''
      #!/bin/sh

      berryc edge_gap 0 0 0 0
      berryc border_width 0
      berryc inner_border_width 0
      berryc title_height 0

      #TODO
      #berryc decorate_new false
      #berryc resize_mask "mod4|ctrl"

      xwallpaper --zoom "${wallpaper}" &
      sxhkd &
      fcitx &
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
      "XF86MonBrightness{Up,Down}" = "brightnessctl set 5%{+,-}";
      "{_,ctrl} + {_,shift} + Print" = "{,region | }{shot,record}"; #TODO
      "super + space" = "fcitx-remote -t";
      "super + {Up,Down,Left,Right,Tab}" = "berryc {window_monocle,window_close,snap_left,snap_right,cycle_focus}";
      "super + Return" = "kitty"; #TODO
    };
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
    settings.clear_all_shortcuts = true;
    keybindings = {
      "super+c" = "copy_to_clipboard";
      "super+v" = "paste_from_clipboard";
      "super+equal" = "change_font_size all +2";
      "super+minus" = "change_font_size all -2";
      "super+0" = "change_font_size all 0";
    };
  };
}
