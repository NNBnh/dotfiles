{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
  bye = pkgs.writeScriptBin "bye" "echo 'Good bye~'; systemctl suspend; clear; sleep 1; echo 'Welcome back!'";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    river                  # Windows manager
    bye                    # Go to sleep
    brightnessctl          # Brightness control
    slurp grim wf-recorder # Screen capture
    wl-clipboard           # Clipboard manager
    sarasa-gothic          # CJK support
    ungoogled-chromium     # Web browser
    blender                # Graphic editor
    godot                  # Game engine
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";
    ".config/river/init" = {
      executable = true;
      text = ''
        #!/bin/sh

        riverctl background-color '0x000000'
        riverctl map normal None XF86AudioMute spawn 'amixer set Master toggle'
        riverctl map normal None XF86AudioRaiseVolume spawn 'amixer set Master 5%+'
        riverctl map normal None XF86AudioLowerVolume spawn 'amixer set Master 5%-'
        riverctl map normal None XF86MonBrightnessUp spawn 'brightnessctl set 5%+'
        riverctl map normal None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
        riverctl map normal None Print spawn 'grim | tee "$(date +%Y-%m-%d_%H-%M-%S_%N).png" | wl-copy'
        riverctl map normal Shift Print spawn 'grim -g "$(slurp)" | tee "$(date +%Y-%m-%d_%H-%M-%S_%N).png" | wl-copy'
        riverctl map normal Control Print spawn 'pkill wf-recorder || wf-recorder --audio --file="$(date +%Y-%m-%d_%H-%M-%S_%N).png"'
        riverctl map normal Control+Shift Print spawn 'pkill wf-recorder || wf-recorder -g "$(slurp)" --audio --file="$(date +%Y-%m-%d_%H-%M-%S_%N).png"'
        riverctl map normal Mod4 Space spawn 'fcitx-remote -t'
        riverctl map normal Mod4 Up toggle-fullscreen
        riverctl map normal Mod4 Down close
        riverctl map normal Mod4 Left focus-view previous
        riverctl map normal Mod4 Right focus-view next
        riverctl map normal Mod4 Return spawn 'kitty'

        fcitx &
      '';
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
