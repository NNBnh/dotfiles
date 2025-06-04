# Install ------------------------------------------------------------------------------------------

if (which brew | is-empty) {
    if (("/home/linuxbrew/.linuxbrew" | path type) != "dir") {
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
}

if (which brew | is-not-empty) {
    let pending_package = ["starship" "eza" "7z" "micro" "jj" "mise" "gleam" "ruby"]
        | filter { |package| which $package | is-empty }

    if ($pending_package | is-not-empty) {
        brew install ...$pending_package
    }
}

mise use --global bun | ignore


# Aliases ------------------------------------------------------------------------------------------

alias l = eza --almost-all --icons --group-directories-first --no-quotes
alias md = mkdir
alias mv = mv --interactive --progress
alias cp = cp --interactive --progress --recursive
alias dl = rm --interactive --recursive --trash
alias a = 7z
alias e = flatpak run dev.zed.Zed


# Environment variables ----------------------------------------------------------------------------

$env.config.show_banner = false
$env.config.buffer_editor = "micro"
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


# Startup ------------------------------------------------------------------------------------------

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
