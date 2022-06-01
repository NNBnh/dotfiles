{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    herbstluftwm picom-next xwallpaper xcape
    brightnessctl scrot xclip xsecurelock
    nur.repos.nnb.bmono sarasa-gothic
    nextcloud-client blender godot
    retroarch multimc osu-lazer
  ];


  # Use TTY as a display manager.
  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which herbstluftwm)";


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


  xdg.configFile."herbstluftwm/autostart" = {
    executable = true;
    text = ''
      #!/bin/sh
      herbstclient mousebind Super-Button1 move
      herbstclient mousebind Super-Shift-Button1 resize
      herbstclient keybind XF86AudioMute         spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"
      herbstclient keybind XF86AudioRaiseVolume  spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"
      herbstclient keybind XF86AudioLowerVolume  spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"
      herbstclient keybind XF86MonBrightnessUp   spawn "brightnessctl set 5%+"
      herbstclient keybind XF86MonBrightnessDown spawn "brightnessctl set 5%-"
      herbstclient keybind Print                 spawn "scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f'"
      herbstclient keybind Ctrl-Print            spawn "scrot '%Y-%m-%d.png' -e 'xclip -selection clipboard -target image/png $f' --select --freeze"
      # TODO
      herbstclient keybind Super-Return spawn "kitty"
      herbstclient keybind Super-Tab cycle_all +1
      herbstclient keybind Super-Shift-Tab cycle_all -1
      herbstclient keybind Super-Up fullscreen toggle
      herbstclient keybind Super-Down close_and_remove
      herbstclient rule --focus=on
      herbstclient rule --floating=true
      herbstclient rule windowtype="_NET_WM_WINDOW_TYPE_NORMAL" --fullscreen=true
      picom --experimental-backends --backend glx --blur-method dual_kawase --shadow &
      xwallpaper --zoom ${builtins.fetchurl "https://i.imgur.com/kmGmba4.png"} &
      fcitx5 &
      xcape -e "Super_L=Super_L|minus"
      xset r rate 300 30
    '';
  };


  home.sessionVariables = {
    XSECURELOCK_FONT = "Bmono";
  	XSECURELOCK_SHOW_DATETIME = true;
    XSECURELOCK_DATETIME_FORMAT = "%r";
  	XSECURELOCK_SHOW_HOSTNAME = 0;
  	XSECURELOCK_SHOW_USERNAME = 0;
  };


  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ unstable.fcitx5-unikey ];
  };
  # Make Kitty use Fcitx5 (some how).
  home.sessionVariables.GLFW_IM_MODULE = "ibus";


  programs = {
    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10; };
      settings = {
        background_opacity = "0.9";
        disable_ligatures = "cursor";
      };
    };

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden ];
      profiles."NNB" = {
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

  # Support precise scrolling in Firefox.
  home.sessionVariables.MOZ_USE_XINPUT2 = "1";
}
