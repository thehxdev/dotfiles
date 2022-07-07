function pi --wraps='sudo pacman -S' --description 'alias pi sudo pacman -S'
  sudo pacman -S $argv; 
end
