{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    picom-next xwallpaper xcape wmfocus brightnessctl
    nur.repos.nnb.bmono sarasa-gothic
    nextcloud-client blender godot
    retroarch multimc osu-lazer
  ];


  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which i3)"; # To use TTY as a display manager.


  xsession = {
    enable = true;
    pointerCursor = { package = pkgs.unstable.phinger-cursors; name = "phinger-cursors-light"; };
  };

  # FIXME xdg.dataFile."fonts/nix-fonts".source = ../.nix-profile/share/fonts;

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu";
    };
    theme = { package = pkgs.gnome.gnome-themes-extra; name = "Adwaita"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  };


  xsession.windowManager.i3 = {
    enable = true;
    config = {
      fonts = { names = [ "Bmono" ]; size = 10.0; };
      bars = [];
      workspaceLayout = "tabbed";
      window.border = 0;
      floating.border = 0;
      colors = {
      	focused         = { background = "#878D96"; border = "#878D96"; childBorder = "#878D96"; indicator = "#878D96"; text = "#FFFFFF"; };
      	focusedInactive = { background = "#525866"; border = "#525866"; childBorder = "#525866"; indicator = "#525866"; text = "#FFFFFF"; };
      	unfocused       = { background = "#525866"; border = "#525866"; childBorder = "#525866"; indicator = "#525866"; text = "#FFFFFF"; };
      	urgent          = { background = "#FFC387"; border = "#FFC387"; childBorder = "#FFC387"; indicator = "#FFC387"; text = "#000000"; };
      };
      modifier = "Mod4";
      focus.followMouse = false;
      keybindings = {
        "button4" = "floating disable";
        "button5" = "floating enable";
        "button2" = "kill";
        "XF86AudioMute"        = "exec pactl set-sink-mute   @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86MonBrightnessUp"   = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
             "Print" = "exec scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f'"; # FIXME
        "Ctrl+Print" = "exec scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f' --select --freeze"; # FIXME
        "Mod4+minus" = "exec wmfocus --font Bmono:32 --chars kdjflsmcie"; # TODO
        "Mod4+Return" = "exec kitty"; # TODO
        "Mod4+Up" = "floating toggle"; # TODO
        "Mod4+Down" = "kill"; # TODO
      };
      startup = [
        { command = "picom --experimental-backends --backend glx --blur-method dual_kawase --shadow --shadow-exclude _NET_FRAME_EXTENTS@:c"; }
        { command = "xwallpaper --zoom ${builtins.fetchurl "https://i.imgur.com/kmGmba4.png"}"; }
        { command = "fcitx5"; }
        { command = "xcape -e 'Super_L=Super_L|minus'"; }
        { command = "xset r rate 300 30"; }
      ];
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ unstable.fcitx5-unikey ];
  };
  home.sessionVariables.GLFW_IM_MODULE = "ibus"; # To make Kitty use Fcitx5 (some how).


  programs = {
    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10; };
      settings = {
        background_opacity = "0.75";
        disable_ligatures = "cursor";
      };
    };

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden ];
      profiles."NNB" = {
        userChrome = "#window-controls { display: none !important; }";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
}
