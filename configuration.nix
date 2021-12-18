{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

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
    shell = pkgs.xonsh;
  };

  programs.xonsh.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true; #TODO remove
    desktopManager.gnome.enable = true; #TODO change
  };

  networking.wireless.iwd.enable = true;
  #FIXME programs.steam.enable = true;
}
