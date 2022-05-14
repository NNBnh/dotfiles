{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which bspwm)"; # To use TTY as login manager.

  home.packages = with pkgs; [
    nur.repos.nnb.bmono sarasa-gothic
    btop nextcloud-client blender godot
    retroarch multimc osu-lazer
  ];


  xdg.dataFile."fonts/nix-fonts".source = ../.nix-profile/share/fonts;
  xsession = {
    enable = true;
    pointerCursor = { package = pkgs.unstable.phinger-cursors; name = "phinger-cursors-light"; };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "menu";
    };
    theme = { package = pkgs.gnome.gnome-themes-extra; name = "Adwaita"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  };


  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 0;
      pointer_modifier = "mod4";
    };
    rules = {
      "*".state = "floating"; # TODO fullscreen
      "*:*:Picture in Picture" = {
        layer = "above";
      };
    };
    extraConfig = "bspc desktop --layout monocle";
    startupPrograms = [
      "${pkgs.picom-next}/bin/picom --experimental-backends --backend glx --blur-method dual_kawase --shadow"
      "${pkgs.xwallpaper}/bin/xwallpaper --zoom ${builtins.fetchurl "https://i.imgur.com/kmGmba4.png"}"
      "sxhkd"
      "fcitx5"
      "${pkgs.xcape}/bin/xcape -e 'Super_L=Super_L|minus'"
      "xset r rate 300 30"
    ];
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86Audio{Mute,RaiseVolume,LowerVolume}" = "pactl set-sink-{mute,volume,volume} @DEFAULT_SINK@ {toggle,+5%,-5%}";
      "XF86MonBrightness{Up,Down}" = "${pkgs.brightnessctl}/bin/brightnessctl set 5%{+,-}";
      "{_,ctrl} + Print" = "${pkgs.maim}/bin/maim {_,--select} | tee $(date +%Y-%m-%d_%H-%M-%S_%N).png" # TODO
                                                            + "| ${pkgs.xclip}/bin/xclip -selection clipboard -target image/png";
      "super + minus" = "kitty"; # TODO
      "super + {_,shift} + Tab" = "bspc node -f {next,prev}.window"; # TODO
    };
  };


  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ unstable.fcitx5-unikey ];
  };
  home.sessionVariables.GLFW_IM_MODULE = "ibus"; # To make Kitty use Fcitx5 (some how).


  xdg.configFile."btop/btop.conf".text = ''
     color_theme = "TTY"
     theme_background = False
     rounded_corners = False
     update_ms = 500
     clock_format = "%r"
   '';

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
