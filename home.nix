{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
  wallpaper = builtins.fetchurl "https://github.com/NNBnh/wallpapers/raw/main/brown-concrete-house-surrounded-by-plants.jpg";
  bye = pkgs.writeScriptBin "bye" "echo 'Good bye~'; systemctl suspend; clear; sleep 1; echo 'Welcome back!'";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    wayfire                # Windows manager
    swaybg                 # Wallpaper setter
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
    ".config/wayfire.conf".text = ''
      [core]
      plugins = animate wobbly blur command scale move resize alpha wrot grid autostart

      close_top_view = <super> KEY_BACKSPACE

      [command]
      binding_switch_input = <super> KEY_SPACE
      command_switch_input = fcitx-remote -t

      repeatable_binding_volume_up = KEY_VOLUMEUP
      command_volume_up = amixer set Master 5%+
      repeatable_binding_volume_down = KEY_VOLUMEDOWN
      command_volume_down = amixer set Master 5%-
      binding_mute = KEY_MUTE
      command_mute = amixer set Master toggle

      repeatable_binding_light_up = KEY_BRIGHTNESSUP
      command_light_up = brightnessctl set 5%+
      repeatable_binding_light_down = KEY_BRIGHTNESSDOWN
      command_light_down = brightnessctl set 5%-

      binding_screen_shot = KEY_SYSRQ
      command_screen_shot = grim - | tee "$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).png" | wl-copy
      binding_screen_shot_region = <ctrl> KEY_SYSRQ
      command_screen_shot_region = grim -g "$(slurp)" - | tee "$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).png" | wl-copy
      binding_screen_record = <shift> KEY_SYSRQ
      command_screen_record = pkill wf-recorder || wf-recorder --audio --file="$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).mkv"
      binding_screen_record_region = <shift> <ctrl> KEY_SYSRQ
      command_screen_record_region = pkill wf-recorder || wf-recorder --geometry "$(slurp)" --audio --file="$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).mkv"

      binding_terminal = <super> KEY_ENTER
      command_terminal = kitty

      [scale]
      duration = 180
      inactive_alpha = 0.5
      toggle = <super>

      [move]
      activate = <super> BTN_LEFT

      [resize]
      activate = <super> BTN_RIGHT

      [alpha]
      modifier = <super>

      [wrot]
      activate = <super> BTN_MIDDLE

      [autostart]
      autostart_wf_shell = false
      background = swaybg -i ${wallpaper}
      language_input = fcitx
    '';
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
      disable_ligatures = "cursor";
      background_opacity = "0.85";
      dynamic_background_opacity = true;
      allow_remote_control = true;
      clear_all_shortcuts = true;
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
