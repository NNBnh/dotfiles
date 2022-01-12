{ config, pkgs, ... }:

let
  bmono = builtins.fetchTarball "https://github.com/NNBnh/bmono/archive/main.tar.gz";
in {
  programs.home-manager.enable = true;

  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    # Core
    wayfire             # Windows manager
    brightnessctl       # Brightness control
    sarasa-gothic       # CJK support
    blueberry           # Bluetooth manager

    # Applications
    ungoogled-chromium  # Web browser
    blender             # Graphic editor
    godot               # Game engine
  ];

  home.file = {
    ".local/share/fonts/bmono".source = "${bmono}/dist/bmono/ttf";
    ".config/wayfire.conf".text = ''
      [core]
      plugins = command scale move resize alpha wrot grid autostart
      background_color = 0.13671875 0.15625 0.2421875 1.0

      close_top_view = <super> KEY_BACKSPACE

      [command]
      binding_terminal = <super> KEY_ENTER
      command_terminal = kitty

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

      binding_screen_shot = <super> KEY_S
      command_screen_shot = grim

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
