{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  home-manager.users.nnb = import ./home.nix;

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

  services.xserver.desktopManager.gnome.enable = true; #TODO change

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ bamboo ];
  };
}
