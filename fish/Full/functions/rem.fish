function rem --wraps='killall emacs; /usr/bin/emacs --daemon' --description 'alias rem killall emacs; /usr/bin/emacs --daemon'
  killall emacs; /usr/bin/emacs --daemon $argv; 
end
