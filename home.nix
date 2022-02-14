{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

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

  home.packages = with pkgs; (
    with (import <unstable> {}); [ berry ] # Window manager
  ) ++ [
    sarasa-gothic # CJK support for font
    xdotool
    (pkgs.writeShellScriptBin "shoty" ''
      if [ -p '/dev/stdin' ]; then
        read -r POSITION SIZE < <(cat -)
        POSITION="+$POSITION"
        SIZE="-s $SIZE"
      fi
      eval ffmpeg -f x11grab $SIZE -i $DISPLAY.0$POSITION -vframes 1 $(date +%Y-%m-%d_%H-%M-%S_%N).png 2>&1 >/dev/null
    '')
    (pkgs.writeShellScriptBin "recky" ''
      if [ -p '/dev/stdin' ]; then
        read -r POSITION SIZE < <(cat -)
        POSITION="+$POSITION"
        SIZE="-s $SIZE"
      fi
      eval ffmpeg -f x11grab $SIZE -i $DISPLAY.0$POSITION -f alsa -i default $(date +%Y-%m-%d_%H-%M-%S_%N).mp4 2>&1 >/dev/null
    '')
    (pkgs.writeShellScriptBin "wmdwim" ''
      DECORATION=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) BERRY_WINDOW_STATUS | cut -d ',' -f 7 | tr -d ' "')
      xdotool getwindowfocus windowstate --remove FULLSCREEN
      case $1 in
        max) berryc window_monocle; berryc toggle_decorations ;;
        left|right) [ $DECORATION = false ] && berryc toggle_decorations; berryc snap_$1;;
      esac
    '')
    (pkgs.writeShellScriptBin "menu4all" "rofi -show drun") #TODO

    ungoogled-chromium blender godot
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

    ".config/berry/autostart".text = ''
      #!/bin/sh

      berryc json_status false
      berryc edge_gap 0 0 0 0
      berryc border_width 8
      berryc inner_border_width 0
      berryc title_height 32
      berryc set_font Bmono-10

      berryc focus_color FFFFFF
      berryc unfocus_color FFFFFF
      berryc inner_focus_color 5890F8
      berryc inner_unfocus_color 525866
      berryc text_focus_color 171726
      berryc text_unfocus_color 171726

      berryc edge_lock false
      berryc move_mask Mod3
      berryc resize_mask Mod4

      ${pkgs.picom}/bin/picom --shadow --shadow-exclude _NET_FRAME_EXTENTS@:c &
      ${pkgs.xwallpaper}/bin/xwallpaper --tile ${builtins.fetchurl "https://i.imgur.com/dHbVnhz.png"} &

      xdotool behave_screen_edge --quiesce 1 top-right exec wmdwim max &
      xdotool behave_screen_edge --quiesce 1 top-left exec menu4all &
      ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|z"
      sxhkd &
      fcitx &
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
      "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
      "{_,control} + Print" = "{_,${pkgs.slop}/bin/slop -f '%x,%y %wx%h' | }shoty";

      "~button{1,2,3}" = "berryc pointer_focus";
      "super + button{4,5}" = "picom-trans -c -- {+,-}5";
      "super + Alt_{L,R}" = "fcitx-remote -t";
      "super + {_,ctrl} + Escape" = "{systemctl suspend,berryc quit}";

      "super + {Tab,Down}" = "berryc {cycle_focus,window_close}";
      "super + {Up,Left,Right}" = "wmdwim {max,left,right}";
      "super + z" = "menu4all";
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
