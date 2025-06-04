use std "path add"
path add "/home/linuxbrew/.linuxbrew/bin"

let mise_path = $nu.default-config-dir | path join mise.nu
mise activate nu | save $mise_path --force
use ($nu.default-config-dir | path join mise.nu)
