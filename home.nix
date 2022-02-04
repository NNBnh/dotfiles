{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [ ungoogled-chromium blender godot slop sarasa-gothic ];

  home.file.".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

  xsession = {
    enable = true;
    # profilePath = ".cache/xprofile";
    # scriptPath = ".cache/xsession";
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "Capitaine Cursors Light";
    };
    windowManager.bspwm = {
      enable = true;
      settings = {
        pointer_action1 = "move";
        pointer_action2 = "resize_corner";
        pointer_action3 = "resize_corner";
      };
      extraConfig = ''
        ${pkgs.xwallpaper}/bin/xwallpaper --zoom ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/wallpapers/main/i5yal/colorful.png"} &
        ${pkgs.xdotool}/bin/xdotool behave_screen_edge top-left key Super_L &
        sxhkd &
        fcitx &
      '';
    };
  };

  services = {
    picom = {
      enable = true;
      blur = true;
      fade = true;
      shadow = true;
      extraOptions = "corner-radius = 10";
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
        "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
        "super + {Tab,Return}" = "{bspc node -f next,kitty}"; #TODO "~Super_{L,R}" = "menu4all";
      };
    };
    screen-locker = {
      enable = true;
      lockCmd = "${pkgs.slock}/bin/slock";
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  programs = {
    rofi = {
      enable = true;
      font = "Bmono 12";
    };
    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10 };
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
