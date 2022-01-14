{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    elvish     # Command shell
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    #helix     # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
  ];

  programs.bash = {
    enable = true;
    initExtra = "[ $SHLVL == 1 ] && exec elvish";
  };

  home.file = {
    ".local/share/colorscheme.cat".source = builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat";

    ".config/elvish/rc.elv".text = ''
      cat ~/.local/share/colorscheme.cat
      if (==s (tty)[0:8] "/dev/tty" ) {
        set edit:prompt = { print ">" }
      } else {
        set edit:prompt = { styled "❯ " bold }
      }
      set edit:rprompt = { styled (tilde-abbr $pwd)" " bright-black }

      set-env EDITOR "hx"
      set-env VISUAL "hx"
      set-env PAGER "hx"
      set-env MANPAGER "hx"

      fn dl [@a]{ trash-put $@a }
      fn md [@a]{ mkdir --parents $@a }
      fn ex [@a]{ patool extract $@a }
      fn ar [@a]{ patool create $@a }
      fn e [@a]{ hx $@a }
      fn g [@a]{ git $@a }
    '';

    ".config/helix/config.toml".text = ''
      theme = "base16_terminal"

      [editor]
      line-number = "absolute"
    '';
  };

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
