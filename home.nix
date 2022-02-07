{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    ungoogled-chromium blender godot
    (pkgs.writeScriptBin "wm" "startx $(which berry)") berry
    (pkgs.writeScriptBin "bye" "systemctl suspend")
    (pkgs.writeScriptBin "lock" "${pkgs.i3lock}/bin/i3lock --color 000000")
    (pkgs.writeScriptBin "menu4all" "rofi -show drun") #TODO
    sarasa-gothic # CJK support for font
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

    ".config/berry/autostart".text = ''
      #!/bin/sh
      berryc decorate_new false
      berryc edge_gap 0 0 0 0
      #TODO berryc resize_mask "mod4|ctrl"
      picom &
      ${pkgs.xwallpaper}/bin/xwallpaper --zoom ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/wallpapers/main/i5yal/colorful.png"} &
      ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|z"
      sxhkd &
      fcitx &
    '';
  };

  xsession = {
    enable = true;
    profilePath = ".cache/X11/xprofile";
    scriptPath = ".cache/X11/xsession";
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
    };
  };
  xresources.path = ".config/X11/xresources";

  services = {
    picom.enable = true;
    sxhkd = {
      enable = true;
      keybindings = {
        "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
        "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
        "{_,ctrl} + {_,shift} + Print" = "{_,region | }{shot,record}"; #TODO
        "~button{1,2,3}" = "berryc pointer_focus";
        "super + button{4,5}" = "picom-trans -c -- {+,-}5";
        "super + {_,shift,ctrl} + {Escape,Capslock}" = "{lock,bye,berryc quit}";
        "super + Alt_{L,R}" = "fcitx-remote -t";
        "super + {Tab,Up,Down,Left,Right}" = "berryc {cycle_focus,window_monocle,window_close,snap_left,snap_right}";
        "super + z" = "menu4all";
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  programs = {
    rofi = { #TODO
      enable = true;
      font = "Bmono 12";
    };
    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10; };
      settings.disable_ligatures = "cursor";
    };
  };
}
