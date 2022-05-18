{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  home.packages = with pkgs; [
    awesome picom-next
    brightnessctl scrot xclip xsecurelock
    nur.repos.nnb.bmono sarasa-gothic
    nextcloud-client blender godot
    retroarch multimc osu-lazer
  ];


  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which awesome)"; # To use TTY as a display manager.


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

  xdg.configFile = {
    "awesome/rc.lua".source = ./rc.lua;
    "awesome/wallpaper.png".source = builtins.fetchurl "https://i.imgur.com/kmGmba4.png";
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
  home.sessionVariables.GLFW_IM_MODULE = "ibus"; # To make Kitty use Fcitx5 (some how).


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
