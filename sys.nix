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

  users.users.nnb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.networkmanager.enable = true;

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;

    #TODO remove
    displayManager.sddm.enable = true;
    windowManager.berry.enable = true;
  };
}
