function fish_prompt
    set -g fish_prompt_pwd_dir_length 4
    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto
    set pad '  '

    # New line
    echo

    # Working directory
    echo -n $USER
    set_color -o brwhite
    echo -n '@'
    set_color normal
    echo -n (prompt_hostname)$pad
    set_color -o brwhite
    echo -n (prompt_pwd)$pad
    set_color normal

    # git
    set_color white
    echo (fish_git_prompt | string trim --chars ' ()')
    set_color normal

    # Background jobs
    for job in (jobs)
        set_color -i brblack
        echo "# $job"
        set_color normal
    end

    # Input
    set_color -o brwhite
    echo -n '$ '
    set_color normal
end
