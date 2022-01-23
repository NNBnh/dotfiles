{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
  bye = pkgs.writeScriptBin "bye" "systemctl suspend";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    wayfire                 # Windows manager
    bye                     # Go to sleep
    brightnessctl           # Brightness control
    slurp grim wf-recorder  # Screen capture
    wl-clipboard            # Clipboard manager
    sarasa-gothic           # CJK support
    ungoogled-chromium      # Web browser
    blender                 # Graphic editor
    godot                   # Game engine
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";
    ".config/wayfire.ini".text = ''
      [core]
      plugins = animate wm-actions scale switcher command grid move resize alpha autostart

      vwidth = 1
      vheight = 1

      close_top_view = <super> KEY_BACKSPACE | <super> KEY_DELETE

      [wm-actions]
      toggle_fullscreen = <super> <shift>

      [scale]
      duration = 180
      inactive_alpha = 0.5
      toggle = <super> | hotspot bottom-left 16x16 0

      [switcher]
      speed = 50
      next_view = <super> KEY_TAB
      prev_view = <super> <shift> KEY_TAB

      [command]
      binding_sleep = <super> KEY_ESC
      command_sleep = bye
      binding_switch_input = <super> <alt>
      command_switch_input = fcitx-remote -t
      binding_terminal = <super> KEY_SPACE
      command_terminal = kitty

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
      command_screen_shot_region = grim -g "$(slurp || echo 'canceled')" - | tee "$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).png" | wl-copy
      binding_screen_record = <shift> KEY_SYSRQ
      command_screen_record = pkill wf-recorder || wf-recorder --audio --file="$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).mkv"
      binding_screen_record_region = <shift> <ctrl> KEY_SYSRQ
      command_screen_record_region = pkill wf-recorder || wf-recorder --geometry "$(slurp || echo 'canceled')" --audio --file="$HOME/t/$(date +%Y-%m-%d_%H-%M-%S_%N).mkv"

      [move]
      activate = <super> BTN_LEFT

      [resize]
      activate = <super> BTN_RIGHT

      [alpha]
      modifier = <super>

      [autostart]
      autostart_wf_shell = false
      input_method = fcitx
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