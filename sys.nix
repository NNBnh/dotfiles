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
    shell = pkgs.zsh;
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    # variables = let inputMethod = "fcitx"; in {
    #   GTK_IM_MODULE = inputMethod;
    #   QT_IM_MODULE = inputMethod;
    #   XMODIFIERS = "@im=${inputMethod}";
    #   QT4_IM_MODULE = inputMethod;
    #   CLUTTER_IM_MODULE = inputMethod;
    #   GLFW_IM_MODULE = inputMethod;
    # };
  };
}
