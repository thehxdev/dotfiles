function nu --wraps='nix-env --uninstall' --description 'alias nu nix-env --uninstall'
  nix-env --uninstall $argv; 
end
