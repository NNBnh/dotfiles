{ config, pkgs, ... }:

{
  imports = [ ./tty.nix ];

  programs.bash.profileExtra = "[ $(tty) = '/dev/tty1' ] && exec startx $(which awesome)"; # To use TTY as login manager.

  home.packages = with pkgs; [
    awesome nur.repos.nnb.bmono sarasa-gothic
    nextcloud-client blender godot bottles
    retroarch multimc osu-lazer
  ];


  xdg.dataFile."fonts/nix-fonts".source = ../.nix-profile/share/fonts;
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


  xdg.configFile."awesome/rc.lua".text = ''
    pcall(require, "luarocks.loader")
    local gears = require("gears")
    local awful = require("awful")
    require("awful.autofocus")
    local wibox = require("wibox")
    local beautiful = require("beautiful")
    local naughty = require("naughty")
    local menubar = require("menubar")

    if awesome.startup_errors then
      naughty.notify(
        {
          preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
          }
      )
    end

    do
      local in_error = false
      awesome.connect_signal(
        "debug::error",
        function(err)
          if in_error then
            return
          end
          in_error = true

          naughty.notify(
            {
              preset = naughty.config.presets.critical,
              title = "Oops, an error happened!",
              text = tostring(err)
            }
          )
          in_error = false
        end
      )
    end

    beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

    modkey = "Mod4"

    awful.layout.layouts = {awful.layout.suit.floating}


    local function set_wallpaper(s)
      if beautiful.wallpaper then
        gears.wallpaper.maximized("${builtins.fetchurl "https://i.imgur.com/dHbVnhz.png"}", s, true)
      end
    end

    screen.connect_signal("property::geometry", set_wallpaper)

    awful.screen.connect_for_each_screen(
      function(s)
        set_wallpaper(s)

        awful.tag({"1"}, s, awful.layout.layouts[1])

        s.mytaglist =
          awful.widget.taglist {
          screen = s,
          filter = awful.widget.taglist.filter.all,
          buttons = taglist_buttons
        }
      end
    )


    globalkeys = gears.table.join(
      awful.key(
        {modkey},
        "Tab",
        function()
          awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
      ),
      awful.key(
        {modkey, "Shift"},
        "Tab",
        function()
          awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
      ),
      awful.key({modkey}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),
      awful.key(
        {modkey},
        "p",
        function()
          menubar.show()
        end,
        {description = "show the menubar", group = "launcher"}
      )
    )
    root.keys(globalkeys)

    clientkeys = gears.table.join(
      awful.key(
        {modkey},
        "Up",
        function(c)
          c.fullscreen = not c.fullscreen
          c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
      ),
      awful.key(
        {modkey},
        "Down",
        function(c)
          c:kill()
        end,
        {description = "close", group = "client"}
      )
    )

    clientbuttons = gears.table.join(
      awful.button(
        {},
        1,
        function(c)
          c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
      ),
      awful.button(
        {modkey},
        1,
        function(c)
          c:emit_signal("request::activate", "mouse_click", {raise = true})
          awful.mouse.client.resize(c)
        end
      )
    )


    awful.rules.rules = {
      {
        rule = {},
        properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          raise = true,
          keys = clientkeys,
          buttons = clientbuttons,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
      },
      {
        rule_any = { type = { "normal" } },
        properties = { fullscreen = true }
      },
      {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
      }
    }

    client.connect_signal(
      "manage",
      function(c)
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
          awful.placement.no_offscreen(c)
        end
      end
    )

    client.connect_signal(
      "request::titlebars",
      function(c)
        local buttons =
          gears.table.join(
          awful.button(
            {},
            1,
            function()
              c:emit_signal("request::activate", "titlebar", {raise = true})
              awful.mouse.client.move(c)
            end
          ),
          awful.button(
            {},
            3,
            function()
              c:emit_signal("request::activate", "titlebar", {raise = true})
              awful.mouse.client.resize(c)
            end
          )
        )

        awful.titlebar(c):setup {
          {
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
          },
          {
            {
              align = "center",
              widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
          },
          {
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
          },
          layout = wibox.layout.align.horizontal
        }
      end
    )
  '';


  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ unstable.fcitx5-unikey ];
  };
  home.sessionVariables.GLFW_IM_MODULE = "ibus"; # To make Kitty use Fcitx5 (some how).


  programs = {
    kitty = {
      enable = true;
      font = { name = "Bmono"; size = 10; };
      settings.disable_ligatures = "cursor";
    };

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden ];
      profiles."NNB" = {
        userChrome = "#window-controls { display: none !important; }";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.uiCustomization.state" = ''
            {
              "placements": {
                "widget-overflow-fixed-list": [ "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action", "ublock0_raymondhill_net-browser-action" ],
                "nav-bar": [ "back-button", "forward-button", "stop-reload-button", "urlbar-container", "downloads-button" ],
                "toolbar-menubar": [ "menubar-items" ],
                "TabsToolbar": [ "tabbrowser-tabs", "new-tab-button", "alltabs-button" ],
                "PersonalToolbar": [ "import-button", "personal-bookmarks" ]
              },
              "seen": [
                "developer-button", "ublock0_raymondhill_net-browser-action",
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action", "_af37054b-3ace-46a2-ac59-709e4412bec6_-browser-action"
              ],
              "dirtyAreaCache": [ "nav-bar", "PersonalToolbar", "toolbar-menubar", "TabsToolbar", "widget-overflow-fixed-list" ],
              "currentVersion": 17,
              "newElementCount": 5
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
}
