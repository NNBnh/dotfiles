{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; (
    with (import <unstable> {}); [ berry ] # Window manager
  ) ++ [
    xdotool # WM utilities
    ungoogled-chromium blender godot # Applications
    (pkgs.writeScriptBin "bye" "systemctl suspend")
    (pkgs.writeScriptBin "lock" "${pkgs.i3lock}/bin/i3lock --color 000000")
    (pkgs.writeScriptBin "menu4all" "rofi -show drun") #TODO
    sarasa-gothic # CJK support for font
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

    ".config/berry/autostart".text = ''
      #!/bin/sh

      berryc border_width 8
      berryc inner_border_width 0
      berryc title_height 32
      berryc set_font Bmono-12
      berryc edge_gap 0 0 0 0
      berryc focus_color FFFFFF
      berryc unfocus_color FFFFFF
      berryc inner_focus_color 5890F8
      berryc inner_unfocus_color 4C988B
      berryc text_focus_color 171726
      berryc text_unfocus_color 171726
      berryc move_mask "Mod2"
      berryc resize_mask "Mod4"

      picom &
      ${pkgs.xwallpaper}/bin/xwallpaper --tile ${builtins.fetchurl "https://i.imgur.com/dHbVnhz.png"} &
      xdotool behave_screen_edge --quiesce 1 top-right exec berryc fullscreen &
      xdotool behave_screen_edge --quiesce 1 top-left exec menu4all &
      ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|z"
      sxhkd &
      fcitx &
    '';
  };

  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which berry)";

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
    picom = {
      enable = true;
      experimentalBackends = true;
      fade = true;
      shadow = true;
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
        "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
        "{_,ctrl} + {_,shift} + Print" = "{_,region | }{shot,record}"; #TODO
        "~button{1,2,3}" = "berryc pointer_focus";
        "super + button{4,5}" = "picom-trans -c -- {+,-}5";
        "super + {_,shift,ctrl} + Escape" = "{lock,bye,berryc quit}";
        "super + Alt_{L,R}" = "fcitx-remote -t";
        "super + {Tab,Up,Down,Left,Right}" = "berryc {cycle_focus,fullscreen,window_close,snap_left,snap_right}";
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
