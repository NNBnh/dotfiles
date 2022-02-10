{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    trash-cli patool edir ffmpeg
    (pkgs.writeScriptBin "theme" "cat ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat"}")
  ];

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      zplug = {
        enable = true;
        zplugHome = ~/.local/share/zplug;
        plugins = [ { name = "marlonrichert/zsh-autocomplete"; } ];
      };
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      history = {
        expireDuplicatesFirst = true;
        path = ".cache/zsh_history";
      };
      localVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
        PAGER = "hx";
        MANPAGER = "hx";
      };
      shellAliases = {
        l = "ls --almost-all --group-directories-first";
        dl = "trash-put";
        md = "mkdir --parents";
        ex = "patool extract";
        ar = "patool create";
        e = "$EDITOR";
        g = "git";
      };
      initExtra = ''
        bindkey "''${key[Up]}" up-line-or-search
        theme
        export PS1="\[\e]0;\w\a\e[0;90m\] \w [E:\$?]\n\[\033[0;1;94m\]❯\[\e[m\] " #TODO better error display
        function chpwd() { l }
      '';
    };
    git = {
      enable = true;
      userName = "NNB";
      userEmail = "nnbnh@protonmail.com";
      extraConfig = {
        credential.helper = "store";
        include.path = builtins.fetchurl "https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt";
      };
    };
  };
}
