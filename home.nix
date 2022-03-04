{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which berry)"; # To use TTY as login manager.

  home.packages = with pkgs; [
    berry xdotool sarasa-gothic blender godot
    (pkgs.writeShellScriptBin "icat" "kitty +kitten icat $@")
    ( # TODO rofi -dmenu -auto-select -matching prefix -format "i"
      pkgs.writeShellScriptBin "menu4all" "rofi -show drun"
    )
  ];

  xsession = {
    enable = true;
    profilePath = "${config.xdg.cacheHome}/X11/xprofile";
    scriptPath = "${config.xdg.cacheHome}/X11/xsession";
    pointerCursor = { package = pkgs.capitaine-cursors; name = "capitaine-cursors"; };
  };
  xresources.path = "${config.xdg.configHome}/X11/xresources";

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    theme = { package = pkgs.materia-theme; name = "Materia-dark"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  };

  xdg.configFile."berry/autostart".text = ''
    #!/bin/sh

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

    ${pkgs.picom}/bin/picom --shadow --shadow-exclude "_NET_FRAME_EXTENTS@:c" --shadow-exclude "class_g = 'Firefox' && argb" &
    ${pkgs.xwallpaper}/bin/xwallpaper --tile ${builtins.fetchurl "https://i.imgur.com/dHbVnhz.png"} &

    ${pkgs.xcape}/bin/xcape -e "Super_L=Super_L|minus"
    sxhkd &
    fcitx5 &
  '';

  services.sxhkd = {
    enable = true;
    keybindings = {
      "~button{1,2,3}" = "berryc pointer_focus";
      "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "amixer set Master {toggle,5%+,5%-}";
      "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
      "{_,ctrl} + Print" = "${pkgs.maim}/bin/maim {_,--select} | tee $(date +%Y-%m-%d_%H-%M-%S_%N).png"
                                                            + "| ${pkgs.xclip}/bin/xclip -selection clipboard -target image/png";
      "alt + Print" = "${pkgs.xcolor}/bin/xcolor --selection clipboard";
      "super + minus" = "menu4all";

      # Will be remove
      "super + {_,ctrl} + Escape" = "{systemctl suspend,berryc quit}";
      "super + {Tab,Down,Up,Left,Right}" = "berryc {cycle_focus,window_close,fullscreen,snap_left,snap_right}";
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ unstable.fcitx5-unikey ];
  };
  home.sessionVariables.GLFW_IM_MODULE = "ibus";

  programs = {
    rofi = {
      enable = true;
      font = "Bmono 12";
      # TODO theme = builtins.fetchurl "";
    };

    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10; };
      settings.disable_ligatures = "cursor";
    };

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin ];
      profiles."NNB" = {
        userChrome = "#window-controls { display: none !important; }";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.uiCustomization.state" = ''
            {
              "placements": {
                "widget-overflow-fixed-list": [ "ublock0_raymondhill_net-browser-action" ],
                "nav-bar": [ "back-button", "forward-button", "stop-reload-button", "urlbar-container", "downloads-button" ],
                "toolbar-menubar": [ "menubar-items" ],
                "TabsToolbar": [ "tabbrowser-tabs", "new-tab-button", "alltabs-button" ],
                "PersonalToolbar": [ "import-button", "personal-bookmarks" ]
              },
              "seen": [ "developer-button", "ublock0_raymondhill_net-browser-action" ],
              "dirtyAreaCache": [ "nav-bar", "PersonalToolbar", "toolbar-menubar", "TabsToolbar", "widget-overflow-fixed-list" ],
              "currentVersion": 17,
              "newElementCount": 3
            }
          '';
          "browser.download.autohideButton" = false;

          "general.autoScroll" = true;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 3;
          "browser.newtabpage.enabled" = false;

          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://dns.quad9.net/dns-query";
          "network.trr.custom_uri" = "https://dns.quad9.net/dns-query";
          "privacy.annotate_channels.strict_list.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;
          "privacy.sanitize.pending" = ''[ { "id": "newtab-container", "itemsToClear": [], "options": {} } ]'';
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "signon.rememberSignons" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "app.shield.optoutstudies.enabled" = true;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
        };
      };
    };
  };

  home.sessionVariables.MOZ_USE_XINPUT2 = "1"; # Support precise scrolling in Firefox.

  xdg.userDirs = { # Prevent Firefox from create these directories.
    desktop = "$HOME";
    download = "$HOME";
  };
}
