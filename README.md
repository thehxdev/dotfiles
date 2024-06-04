# DotFiles

My configuration files for my [NixOS](https://nixos.org) setup.


## NixOS config

Get `configuration.nix` file (as root):
```bash
# Create a backup from old config
mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak

# Download new config
curl -L -o '/etc/nixos/configuration.nix' 'https://raw.githubusercontent.com/thehxdev/dotfiles/main/nixos/configuration.nix'
```
