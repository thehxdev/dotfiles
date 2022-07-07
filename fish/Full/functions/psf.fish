function psf --wraps='sudo pacman -Ss' --description 'alias psf sudo pacman -Ss'
  sudo pacman -Ss $argv; 
end
