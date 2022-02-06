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
  };

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    libinput.enable = true;
    xkbOptions = "terminate:ctrl_alt_bksp,caps:escape";
  };

  users.users.nnb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
