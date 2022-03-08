{ config, pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
    uinput.enable = true;
  };

  networking.networkmanager.enable = true;

  services = {
    timesyncd.enable = false;
    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      libinput.enable = true;
      xkbOptions = "terminate:ctrl_alt_bksp,caps:escape";
    };
    joycond.enable = true;
  };

  users.users.nnb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  programs = {
    dconf.enable = true; # For GTK theme to load.
    # steam.enable = true;
  };
}
