#!/bin/bash

# install work tools
sudo pacman -S zsh bitwarden neovim tmux obsidian gcc xclip tree ctags fd \
    ripgrep postgresql alacritty flameshot docker nodejs npm dbeaver \
    base-devel git wireguard-tools --noconfirm --needed


# install AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


# install extra tools
yay -S google-chrome postman-bin slack-desktop


# set zsh as default
chsh -s /bin/zsh


# alacritty config
mv ~/.config/alacritty/alacritty.toml \
    ~/.config/alacritty/alacritty_default.toml
cp -r alacritty ~/.config
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme \
    ~/.config/alacritty/themes


# git config
read -p "Enter your Github access token: " git_token
echo "https://kizeev:$git_token@github.com" >> ~/.git-credentials

cat << EOF > ~/.gitconfig
[user]
    name = kizeev
    email = kizalvic@gmail.com
[credential]
    helper = store
EOF


# nvim config
cp -r nvim ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim -c "PackerSync"


# tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/
cp ~/.tmux/.tmux.conf.local ~/


# config wireguard
sudo modprobe wireguard
