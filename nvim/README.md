# install vim-plug:
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
in neovim (command mode) install plugins with ```:PlugInstall```

# install yarn & some pkgs:
```sh
sudo pacman -Sy yarn jedi-language-server nodejs
```
# then:
```sh
cd $HOME/.local/share/nvim/plugged/coc.nvim
yarn install
```
