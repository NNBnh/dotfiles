{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xonsh      # Command shell
    exa        # Pretty files list
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    helix      # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
  ];

  home.file.".config/xonsh/rc.xsh".source = ./rc.xsh;
  home.file.".local/share/colorscheme.cat".source = builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat";

  programs.git = {
    enable = true;
    userName = "NNB";
    userEmail = "nnbnh@protonmail.com";
    extraConfig = {
      credential.helper = "store";
      include.path = builtins.fetchurl "https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt";
    };
  };
}
