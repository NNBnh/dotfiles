{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    berry sarasa-gothic xdotool
    ungoogled-chromium blender godot
    (pkgs.writeScriptBin "wm" "exec startx $(which berry)")
    (pkgs.writeScriptBin "bye" "systemctl suspend")
    (pkgs.writeScriptBin "lock" "${pkgs.i3lock}/bin/i3lock --color 000000")
    (pkgs.writeScriptBin "menu4all" "kitty") #TODO
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

    ".config/berry/autostart".text = ''
      #!/bin/sh
      berryc border_width 2
      berryc inner_border_width 0
      berryc title_height 24
      berryc set_font Bmono-12
      berryc edge_gap 0 0 0 0
      berryc focus_color 5890F8
      berryc unfocus_color 525866
      berryc inner_focus_color 5890F8
      berryc inner_unfocus_color 525866
      berryc text_focus_color 171726
      berryc text_unfocus_color 171726
      berryc resize_mask "mod4"
      picom &
      ${pkgs.xwallpaper}/bin/xwallpaper --zoom ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/wallpapers/main/i5yal/colorful.png"} &
      xdotool behave_screen_edge top-left exec menu4all &
      xdotool behave_screen_edge top-right exec berryc fullscreen &
      ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|s"
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
        "~button{1,2,3,4,5}" = "berryc pointer_focus";
        "super + button{4,5}" = "picom-trans -c -- {+,-}5";
        "super + {Tab,Return,Up,Down,Left,Right}" = "berryc {cycle_focus,fullscreen,window_monocle,window_close,snap_left,snap_right}";
        "super + s" = "menu4all";
      };
    };

    screen-locker = {
      enable = true;
      lockCmd = "lock";
    };
  };

  i18n.inputMethod = { #FIXME
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
      settings = {
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
  };
}
