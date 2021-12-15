{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  programs.xonsh.enable = true;
  users.users.nnb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.xonsh;
  };

  services.xserver = {
    enable = true;
    xkbOptions = "terminate:ctrl_alt_bksp,caps:escape";
    displayManager.sddm.enable = true; #TODO
    desktopManager.gnome.enable = true; #TODO
  };

  i18n.inputMethod = { #FIXME
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Utilitie
    efibootmgr           # Boot manager
    brightnessctl        # Screen backlight
    playerctl            # Control media
    dunst                # Notification daemon

    # Resource
    #bmono               # Mono font
    sarasa-gothic        # Non Latin support for font
    twemoji-color-font   # Emoji support for font
    bibata-cursors       # Cursor theme

    # Terminal
    #superb-st           # Terminal emulator
    helix                # Text editor
    git                  # Version control system
    ffmpeg               # Media manipulator
    asciinema            # Record terminal sessions
    figlet               # Text banner generator
    nms                  # Hacker mode

    # Programming
    ruby_3_0             # Scripting language
    crystal              # Compiled language

    # Applications
    brave                # Browser
    krita                # Image editor
    blender              # Motion graphics
    godot                # Game engine

    # Games
    retroarch            # Retro emulators
    multimc              # Minecraft launcher
    osu-lazer            # Rhythm game
  ];

  #programs.git = { #TODO
  #  enable = true;
  #  userName  = "NNB";
  #  userEmail = "nnbnh@protonmail.com";
  #  extraConfig = {
  #    credential.helper = "store";
  #  };
  #};

  #programs.steam.enable = true;
}
