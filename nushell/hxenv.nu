# $env.path ++= ["~/.local/bin", "~/go/bin", "~/opt/python/3.13.2/bin", "~/opt/llvm18.1.8/bin"]

$env.config.buffer_editor = "nano"
$env.config.show_banner = false

alias tm = tmux
alias nv = nvim
alias zl = zellij

def ll [p?: string = ".", ...rest] {
  let normalized_path = (
    if ($p | str contains "~") {
      ($p | path expand)
    } else {
      $p
    }
  )
  ls $normalized_path ...$rest | sort-by type
};

# Cargo
# source ($nu.home-path | path join ".cargo/env.nu")

# Starship
# mkdir ($nu.data-dir | path join "vendor/autoload")
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# ASDF
# let shims_dir = (
#   if ( $env | get --ignore-errors ASDF_DATA_DIR | is-empty ) {
#     $env.HOME | path join '.asdf'
#   } else {
#     $env.ASDF_DATA_DIR
#   } | path join 'shims'
# )
# $env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )
