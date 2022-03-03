{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ruby_3_0 xonsh trash-cli patool edir ffmpeg
    (pkgs.writeScriptBin "theme" "cat ${builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-sea.cat"}")
  ];

  home.file."${config.xdg.configHome}/xonsh/rc.xsh".text = ''
    theme

    $TITLE = "{cwd}"
    $PROMPT = "\033[0;1;90m {cwd}\033[0m\n\033[1;94m❯ "
    $MULTILINE_PROMPT = "|"
    $XONSH_AUTOPAIR = $XONSH_CTRL_BKSP_DELETION = $COMPLETE_DOTS = $DOTGLOB = $AUTO_CD = True

    aliases["."] = "ls --almost-all --group-directories-first"
    aliases["dl"] = "trash-put"
    aliases["md"] = "mkdir --parents"
    aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "kak"
    aliases["g"] = "git"

    @events.on_postcommand
    def print_exitcode(cmd, rtn, out, ts, **kw):
      if rtn:
        print(f"\033[7;91m E:{str(rtn)} \033[0m")

    @events.on_chdir
    def auto_ls(olddir, newdir, **kw):
      .
  '';

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.cacheHome}/bash_history";
      initExtra = "[ -z $XONSH_AUTOPAIR ] && exec xonsh";
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

    kakoune = { # TODO remove
      enable = true;
      extraConfig = ''
        source ${builtins.fetchurl "https://raw.githubusercontent.com/robertmeta/plug.kak/master/rc/plug.kak"}
        set-option global plug_install_dir ${config.xdg.dataHome}/kak
        set-option global plug_always_ensure true

        plug "NNBnh/base16-terminal.kak" theme config %{ colorscheme base16-terminal }
        plug "NNBnh/bmap.kak" config %{ bmap-load; bmap-enable }
        plug "Screwtapello/kakoune-inc-dec" domain "gitlab.com"
        plug "h-youhei/kakoune-surround"
        plug "alexherbo2/auto-pairs.kak" config %{ enable-auto-pairs }
        plug "occivink/kakoune-find"
        # plug "eraserhd/kak-ansi"

        set-option global scrolloff 3,7
        set-option global tabstop 4
        set-option global indentwidth 0
        set-option global ui_options terminal_padding_char=
        set-option global modelinefmt "%val{bufname} {{context_info}} {{mode_info}} %val{cursor_line}/%val{buf_line_count} %val{cursor_char_column} "

        add-highlighter global/ number-lines -relative -hlcursor -separator " " -min-digits 3
        add-highlighter global/ show-whitespaces -tab "▏" -tabpad " " -lf " " -spc " " -nbsp "·"
        add-highlighter global/ show-matching
        add-highlighter global/ dynregex "%reg{/}" 0:MatchingChar
        add-highlighter global/ regex "\h+$" 0:+u
      '';
    };
  };
}
