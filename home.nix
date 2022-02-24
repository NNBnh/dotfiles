{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which berry)";

  xsession = {
    enable = true;
    profilePath = "${config.xdg.cacheHome}/X11/xprofile";
    scriptPath = "${config.xdg.cacheHome}/X11/xsession";
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
    };
  };
  xresources.path = "${config.xdg.configHome}/X11/xresources";

  nixpkgs.config = {
    allowUnfree = true;
    chromium.enableWideVine = true;
  };
  home.packages = with pkgs; (
    with (import <unstable> {}); [ berry ]
  ) ++ [
    sarasa-gothic # CJK support for font
    xdotool maim
    (pkgs.writeShellScriptBin "recky" "ffmpeg -f x11grab -i $DISPLAY -f alsa -i default $(date +%Y-%m-%d_%H-%M-%S_%N).mp4")
    (
      pkgs.writeShellScriptBin "wmdwim" ''
        DECORATION=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) BERRY_WINDOW_STATUS | cut -d "," -f 7 | tr -d ' "')
        xdotool getwindowfocus windowstate --remove FULLSCREEN
        case $1 in
          max) berryc window_monocle; berryc toggle_decorations ;;
          left|right) [ $DECORATION = false ] && berryc toggle_decorations; berryc snap_$1;;
        esac
      ''
    )
    ( #TODO rofi -dmenu -auto-select -matching prefix -format "i"
      pkgs.writeShellScriptBin "menu4all" "rofi -show drun"
    )

    ungoogled-chromium blender godot
  ];

  home.file = {
    "${config.xdg.dataHome}/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

    "${config.xdg.configHome}/berry/autostart".text = ''
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
      berryc move_mask Mod3 # To disable
      berryc resize_mask Mod4

      ${pkgs.picom}/bin/picom --shadow --shadow-exclude _NET_FRAME_EXTENTS@:c &
      ${pkgs.xwallpaper}/bin/xwallpaper --tile ${builtins.fetchurl "https://i.imgur.com/dHbVnhz.png"} &

      xdotool behave_screen_edge --quiesce 1 top-right exec wmdwim max &
      xdotool behave_screen_edge --quiesce 1 top-left exec menu4all &
      ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|minus"
      sxhkd &
      fcitx &
    '';
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "~button{1,2,3}" = "berryc pointer_focus";
      "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
      "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
      "{_,ctrl} + Print" = "{maim,maim --select} | tee $(date +%Y-%m-%d_%H-%M-%S_%N).png | ${pkgs.xclip}/bin/xclip -selection clipboard -target image/png";
      "alt + Print" = "${pkgs.xcolor}/bin/xcolor --selection clipboard";
      "super + button{4,5}" = "${pkgs.picom}/bin/picom-trans -c -- {+,-}5";
      "super + minus" = "menu4all";

      # Will be remove
      "super + Alt_{L,R}" = "fcitx-remote -t";
      "super + {_,ctrl} + Escape" = "{systemctl suspend,berryc quit}";
      "super + {Tab,Down}" = "berryc {cycle_focus,window_close}";
      "super + {Up,Left,Right}" = "wmdwim {max,left,right}";
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
