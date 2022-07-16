function ng --wraps='nix-store --gc' --description 'alias ng nix-store --gc'
  nix-store --gc $argv; 
end
