function ni --wraps='nix-env -iA' --description 'alias ni nix-env -iA'
  nix-env -iA $argv; 
end
