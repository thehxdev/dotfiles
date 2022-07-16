function nixremprofile --wraps='nix-collect-garbage -d' --description 'alias nixremprofile nix-collect-garbage -d'
  nix-collect-garbage -d $argv; 
end
