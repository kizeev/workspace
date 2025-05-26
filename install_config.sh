#!/bin/bash

# install work tools
sudo pacman -S zsh bitwarden neovim tmux obsidian gcc xclip tree ctags fd \
   ripgrep postgresql alacritty flameshot docker nodejs npm dbeaver \
   base-devel git wireguard-tools net-tools zip unzip python-pipx pyright \
   --noconfirm --needed


# pipx config
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
pipx completions


# install extra tools from AUR
pipx install ranger-fm


# install AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


# install extra tools from AUR
yay -S google-chrome postman-bin slack-desktop


# set zsh as default
chsh -s /bin/zsh


# install fonts
mkdir -p "~/.local/share/fonts"
find "workspace/fonts" \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" \) -type f -print0 | \
    xargs -0 -I {} cp "{}" "~/.local/share/fonts/"

# alacritty config
mv ~/.config/alacritty/alacritty.toml \
    ~/.config/alacritty/alacritty_default.toml
cp -r ~/workspace/alacritty ~/.config
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme \
    ~/.config/alacritty/themes
cp ~/workspace/.p10k.zsh ~/


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
cp -r ~/workspace/nvim ~/.config
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# tmux config
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/
cp ~/.tmux/.tmux.conf.local ~/


# config wireguard
sudo modprobe wireguard


# config docker
sudo systemctl enable docker
sudo systemctl start docker
sudo docker run -d --hostname rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.13-management
sudo docker run -p 6379:6379 --name redis -d redis
