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
    shell = pkgs.xonsh;
  };

  programs.xonsh.enable = true;

  services.xserver.enable = true;

  i18n.inputMethod = { #TODO move back to home manager
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ bamboo ];
  };
}
