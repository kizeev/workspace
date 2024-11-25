#!/bin/bash

# install work tools
sudo pamac install google-chrome postman-bin
sudo pacman -S bitwarden neovim tmux obsidian gcc xclip tree ctags fd ripgrep \
    postgresql alacritty flameshot docker nodejs npm --noconfirm


# git config
read -p "Enter your Github access token: " git_token
echo "$git_token" >> ~/.git-credentials

cat << EOF > ~/.gitconfig
[user]
    name = kizeev
    email = kizalvic@gmail.com
[credential]
    helper = store
EOF


# nvim config
cp -r .nvim ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim -c "PackerInstall" -c "quit"


# tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/
cp .tmux/.tmux.conf.local .
