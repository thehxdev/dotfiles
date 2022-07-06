nitrogen --restore &
picom --experimental-backend &
volumeicon &
nm-applet &
/usr/bin/emacs --daemon &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 &
flameshot &
lxsession &
setxkbmap -layout 'us,ir' -option 'grp:alt_shift_toggle' &

### Set Default Browser ###
export BROWSER=/usr/bin/firefox

### Set Default Editor ###
export EDITOR=/usr/bin/nvim

### devs ###
#export PATH="$HOME/.cargo/bin:$PATH"      # Rust
#export PATH="$HOME/.anaconda3/bin:$PATH"  # Python Anaconda
#export PATH="$HOME/.ghcup/bin:$PATH"      # Haskell
export PATH="$HOME/.local/bin:$PATH"       # bin directory in .local

