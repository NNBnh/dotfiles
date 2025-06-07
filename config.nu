# Install ------------------------------------------------------------------------------------------

if (which brew | is-empty) {
    if (("/home/linuxbrew/.linuxbrew" | path type) != "dir") {
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
}

if (which brew | is-not-empty) {
    if (which bun | is-empty) {
        brew tap "oven-sh/bun"
    }

    let pending_package = ["starship" "eza" "rg" "7z" "micro" "jj" "bun" "gleam" "ruby"]
        | filter { |package| which $package | is-empty }

    if ($pending_package | is-not-empty) {
        brew install ...$pending_package
    }
}


# Aliases ------------------------------------------------------------------------------------------

alias l = eza --almost-all --git --header --icons --group-directories-first --no-quotes
alias ll = l --long
alias md = mkdir
alias mv = mv --interactive --progress
alias cp = cp --interactive --progress --recursive
alias rm = rm --recursive
alias d = rm
alias a = 7z
alias e = flatpak run dev.zed.Zed


# Environment variables ----------------------------------------------------------------------------

$env.config.show_banner = false

$env.EDITOR = "micro"
$env.VISUAL = $env.EDITOR
$env.config.buffer_editor = $env.EDITOR

$env.config.rm.always_trash = true

$env.config.hooks = {
    env_change: {
        PWD: [
            {|before, after| l $after }
        ]
    }
}


# Functions ----------------------------------------------------------------------------------------

# Convenient selection for files management.
$env.SEL = []

# Add files or directories to `$env.SEL`.
def --env s [...items] {
    $env.SEL = ($items | path expand --strict)
    $env.SEL
}

# Using `mv` with `$env.SEL` if `args` is empty.
def m [...args] {
    if ($args | is-empty) {
        mv ...$env.SEL .
    } else {
        mv ...$args
    }
}

# Using `cp` with `$env.SEL` if `args` is empty.
def c [...args] {
    if ($args | is-empty) {
        cp ...$env.SEL .
    } else {
        cp ...$args
    }
}

# Open a new terminal.
def n [] {
    let $terminal_paths = which $env.TERM_PROGRAM | get path

    if ($terminal_paths | is-empty) {
        return
    }

    let $terminal_path = | first

    job spawn {
        nu --commands $terminal_path out+err>| ignore
    }
    | ignore
}


# Startup ------------------------------------------------------------------------------------------

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
