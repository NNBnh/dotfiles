{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    sarasa-gothic # CJK support
    ungoogled-chromium # Web browser
    blender # Graphic editor
    godot # Game engine
  ];

  home.file.".local/share/fonts/bmono".source = "${builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz"}/dist/bmono/ttf";

  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      pointer_action1 = "move";
      pointer_action2 = "resize_corner";
      pointer_action3 = "resize_corner";
    };
    extraConfig = ''
      ${pkgs.xwallpaper}/bin/xwallpaper --zoom "${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/wallpapers/main/brown-concrete-house-surrounded-by-plants.jpg"}" &
      ${pkgs.xdotool}/bin/xdotool behave_screen_edge top-left key Super_L &
      sxhkd &
      fcitx &
    '';
  };

  services = {
    picom = {
      enable = true;
      blur = true;
      fade = true;
      shadow = true;
    };
    sxhkd = {
      enable = true;
      keybindings = {
        "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
        "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
        "~Super_{L,R}" = "menu4all"; #TODO
      };
    };
    screen-locker = {
      enable = true;
      lockCmd = "${pkgs.slock}/bin/slock";
    };
  };

  programs.rofi = {
    enable = true;
    font = "Bmono 12";
  };

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  programs.kitty = {
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
}
