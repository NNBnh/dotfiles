{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    xonsh      # Command shell
    trash-cli  # Trash manager
    patool     # Archive
    edir       # Bulk edit
    helix     # Text editor
    ffmpeg     # Media manipulator
    ruby_3_0   # Scripting language
  ];

  home.file = {
    ".local/share/colorscheme.cat".source = builtins.fetchurl "https://raw.githubusercontent.com/NNBnh/da-one/main/da-one-ocean.cat";

    ".config/xonsh/rc.xsh".text = ''
      import os
      cat ~/.local/share/colorscheme.cat

      $TITLE = "{cwd}"
      $PROMPT = "\033[0;90m {cwd}\033[0m\n\033[1;94m❯ "
      $MULTILINE_PROMPT = "|"

      $XONSH_AUTOPAIR = True
      $XONSH_CTRL_BKSP_DELETION = True

      $COMPLETE_DOTS = True
      $DOTGLOB = True
      $AUTO_CD = True

      @events.on_postcommand
      def print_exitcode(cmd, rtn, out, ts, **kw):
        if rtn:
          print(f"\033[7;91m E:{str(rtn)} \033[0m")

      @events.on_chdir
      def auto_ls(olddir, newdir, **kw):
        .

      $SELECTION = None
      def set_file_select(items):
        $SELECTION = [os.path.abspath(item) for item in items]

      aliases["s"] = lambda args: set_file_select(args)
      aliases["mv"] = lambda args: execx("mv @($SELECTION) .") if not args else execx(" ".join(["mv"] + args))
      aliases["cp"] = lambda args: execx("cp -r @($SELECTION) .") if not args else execx(" ".join(["cp -r"] + args))
      aliases["ln"] = lambda args: execx("ln -s @($SELECTION) .") if not args else execx(" ".join(["ln -s"] + args))

      aliases["."] = "ls --almost-all --group-directories-first"
      aliases["dl"] = "trash-put"
      aliases["md"] = "mkdir --parents"
      aliases["ex"] = "patool extract"
      aliases["ar"] = "patool create"
      aliases["e"] = $EDITOR = $VISUAL = $PAGER = $MANPAGER = "hx"
      aliases["g"] = "git"
    '';

    ".config/helix/config.toml".text = ''
      theme = "base16_terminal"

      [editor]

      line-number = "relative"

      [keys.normal]

      "esc" = "collapse_selection"
      "tab" = "goto_next_buffer"
      "S-tab" = "goto_previous_buffer"

      "i" = "move_line_up"
      "I" = "copy_selection_on_prev_line"
      "k" = "move_line_down"
      "K" = "copy_selection_on_next_line"
      "j" = "move_char_left"
      "J" = "jump_backward"
      "l" = "move_char_right"
      "L" = "jump_forward"
      "u" = "move_prev_word_start"
      "U" = "move_prev_long_word_start"
      "o" = ["move_next_word_end", "extend_char_right"]
      "O" = ["move_next_long_word_end", "extend_char_right"]

      "d" = "insert_mode" #FIXME
      "D" = "code_action"
      "f" = "search"
      "F" = "rsearch"
      "s" = "extend_line"
      "S" = "extend_to_line_bounds"
      "e" = "replace"
      "E" = "rename_symbol"
      "r" = "select_regex"
      "R" = "split_selection"
      "w" = "keep_primary_selection"
      "W" = "remove_primary_selection"

      "z" = "undo"
      "Z" = "redo"
      "x" = "delete_selection"
      "X" = "delete_selection_noyank"
      "c" = "yank"
      "C" = "no_op"
      "v" = ["collapse_selection", "paste_before"]
      "V" = "no_op" #TODO

      "h" = "search_next"
      "H" = "search_prev"
      "b" = "no_op" #TODO
      "B" = "no_op" #TODO
      "n" = "add_newline_below"
      "N" = "add_newline_above"
      "p" = "replay_macro"
      "P" = "record_macro"

      "," = "decrement"
      "lt" = "switch_to_lowercase"
      "." = "increment"
      "gt" = "switch_to_uppercase"
      "/" = "toggle_comments"
      "?" = "no_op" #TODO
      "`" = "shell_pipe_to"
      "~" = "shell_pipe"

      "[" = "indent"
      "{" = "no_op" #TODO
      "]" = "unindent"
      "}" = "no_op" #TODO
      "\\" = "align_selections"
      "|" = "no_op" #TODO

      "minus" = "no_op" #TODO
      "_" = "no_op"
      "plus" = "no_op" #TODO
      "=" = "no_op"

      "!" = "no_op"
      "@" = "no_op"
      "#" = "no_op"
      "$" = "no_op"
      "percent" = "no_op"
      "^" = "no_op"
      "&" = "no_op"
      "*" = "no_op"
      "(" = "no_op"
      ")" = "no_op"

      "'" = "select_register"
      "\"" = "no_op"
      "semicolon" = "command_mode"
      ":" = ["collapse_selection", "shell_insert_output"]

      "a" = "select_mode"
      "A" = "select_all"
      "q" = "flip_selections"
      "Q" = "ensure_selections_forward"
      "g" = "rotate_selections_forward"
      "G" = "rotate_selections_backward"
      "t" = "rotate_selection_contents_backward"
      "T" = "rotate_selection_contents_forward"

      "m" = "no_op" #TODO
      "M" = "match_brackets"
      "y" = "join_selections"
      "Y" = "no_op" #TODO

      [keys.normal."space"]

      "space" = ["align_view_center", "align_view_middle", "hover"] #TODO
      "ret" = "split_selection_on_newline"
      "tab" = "buffer_picker"
      "S-tab" = "file_picker"

      "i" = "goto_file_start" #TODO
      "I" = "scroll_up"
      "k" = "goto_file_end" #TODO
      "K" = "scroll_down"
      "j" = "extend_to_line_start"
      "J" = "no_op" #TODO
      "l" = "extend_to_line_end_newline"
      "L" = "no_op" #TODO
      "u" = "goto_first_nonwhitespace" #TODO
      "U" = "page_up"
      "O" = "page_down"

      "d" = "surround_add"
      "f" = "search_selection"
      "s" = "select_textobject_inner"
      "e" = "surround_replace"
      "r" = "keep_selections"
      "R" = "remove_selections"
      "w" = "shell_keep_pipe"

      "z" = "earlier"
      "Z" = "later"
      "x" = "surround_delete"

      "n" = "open_below"
      "N" = "open_above"

      "," = "goto_prev_diag"
      "lt" = "goto_first_diag"
      "." = "goto_next_diag"
      "gt" = "goto_last_diag"
      "/" = "format_selections"

      "a" = "select_textobject_around"
      "q" = "trim_selections"

      "m" = "symbol_picker"
      "M" = "workspace_symbol_picker"
      "y" = "no_op" #TODO

      [keys.select]

      "esc" = "collapse_selection"
      "tab" = "goto_next_buffer"
      "S-tab" = "goto_previous_buffer"

      "i" = "extend_line_up"
      "I" = "copy_selection_on_prev_line"
      "k" = "extend_line_down"
      "K" = "copy_selection_on_next_line"
      "j" = "extend_char_left"
      "J" = "jump_backward"
      "l" = "extend_char_right"
      "L" = "jump_forward"
      "u" = "extend_prev_word_start"
      "U" = "extend_prev_long_word_start"
      "o" = ["extend_next_word_end", "extend_char_right"]
      "O" = ["extend_next_long_word_end", "extend_char_right"]

      "d" = "change_selection_noyank" #TODO
      "D" = "code_action"
      "f" = "search" #TODO
      "F" = "rsearch" #TODO
      "s" = "extend_line"
      "S" = "extend_to_line_bounds"
      "e" = "replace"
      "E" = "rename_symbol"
      "r" = "select_regex"
      "R" = "split_selection"
      "w" = "keep_primary_selection"
      "W" = "remove_primary_selection"

      "z" = "undo"
      "Z" = "redo"
      "x" = "delete_selection"
      "X" = "delete_selection_noyank"
      "c" = "yank"
      "C" = "no_op"
      "v" = ["extend_char_right", "delete_selection_noyank", "paste_before"] #FIXME
      "V" = "no_op" #TODO

      "h" = "extend_search_next"
      "H" = "extend_search_prev"
      "b" = "no_op" #TODO
      "B" = "no_op" #TODO
      "n" = "add_newline_below"
      "N" = "add_newline_above"
      "p" = "replay_macro"
      "P" = "record_macro"

      "," = "decrement"
      "lt" = "switch_to_lowercase"
      "." = "increment"
      "gt" = "switch_to_uppercase"
      "/" = "toggle_comments"
      "?" = "no_op" #TODO
      "`" = "shell_pipe_to"
      "~" = "shell_pipe"

      "[" = "indent"
      "{" = "no_op" #TODO
      "]" = "unindent"
      "}" = "no_op" #TODO
      "\\" = "align_selections"
      "|" = "no_op" #TODO

      "minus" = "no_op" #TODO
      "_" = "no_op"
      "plus" = "no_op" #TODO
      "=" = "no_op"

      "!" = "no_op"
      "@" = "no_op"
      "#" = "no_op"
      "$" = "no_op"
      "percent" = "no_op"
      "^" = "no_op"
      "&" = "no_op"
      "*" = "no_op"
      "(" = "no_op"
      ")" = "no_op"

      "'" = "select_register"
      "\"" = "no_op"
      "semicolon" = "command_mode"
      ":" = ["extend_char_right", "delete_selection_noyank", "shell_insert_output"]

      "a" = "normal_mode"
      "A" = "select_all"
      "q" = "flip_selections"
      "Q" = "ensure_selections_forward"
      "g" = "rotate_selections_forward"
      "G" = "rotate_selections_backward"
      "t" = "rotate_selection_contents_backward"
      "T" = "rotate_selection_contents_forward"

      "m" = "no_op" #TODO
      "M" = "match_brackets" #TODO
      "y" = "join_selections"
      "Y" = "no_op" #TODO

      [keys.select."space"]

      "space" = ["align_view_center", "align_view_middle", "hover"] #TODO
      "ret" = "split_selection_on_newline"
      "tab" = "buffer_picker"
      "S-tab" = "file_picker"

      "i" = "goto_file_start" #TODO
      "I" = "scroll_up"
      "k" = "goto_file_end" #TODO
      "K" = "scroll_down"
      "j" = "extend_to_line_start"
      "J" = "no_op" #TODO
      "l" = "extend_to_line_end_newline"
      "L" = "no_op" #TODO
      "u" = "goto_first_nonwhitespace" #TODO
      "U" = "page_up"
      "O" = "page_down"

      "d" = "surround_add"
      "f" = "search_selection"
      "s" = "select_textobject_inner"
      "e" = "surround_replace"
      "r" = "keep_selections"
      "R" = "remove_selections"
      "w" = "shell_keep_pipe"

      "z" = "earlier"
      "Z" = "later"
      "x" = "surround_delete"

      "n" = "open_below"
      "N" = "open_above"

      "," = ["select_mode", "goto_prev_diag"]
      "lt" = ["select_mode", "goto_first_diag"]
      "." = ["select_mode", "goto_next_diag"]
      "gt" = ["select_mode", "goto_last_diag"]
      "/" = "format_selections"

      "a" = "select_textobject_around"
      "q" = "trim_selections"

      "m" = "symbol_picker"
      "M" = "workspace_symbol_picker"
      "y" = "no_op" #TODO
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
