{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in

{
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

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true; #TODO
    desktopManager.gnome.enable = true; #TODO
  };

  i18n.inputMethod = { #TODO
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ unikey ];
  };

  programs.xonsh.enable = true;
  programs.git.enable = true;
}
