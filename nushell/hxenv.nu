$env.path ++= ["~/.local/bin", "~/opt/_root/bin", "~/go/bin"]

$env.config.buffer_editor = "micro"
$env.config.show_banner = false

alias tm = tmux
alias nv = nvim

# Cargo
# source ($nu.home-path | path join ".cargo/env.nu")
