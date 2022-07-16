function nixremold --wraps='nix-env --delete-generations old' --description 'alias nixremold nix-env --delete-generations old'
  nix-env --delete-generations old $argv; 
end
