#!/bin/bash
set -euo pipefail

# install work tools
# assumes CachyOS (for the cachyos-zsh-config package/repo — see .zshrc);
# on plain Arch, drop cachyos-zsh-config and configure zsh/p10k yourself
# (pyright and ctags dropped: pyright is installed by nvim's mason.nvim,
# ctags was only used by namu.nvim, which is no longer in the nvim config)
sudo pacman -S zsh bitwarden neovim tmux obsidian gcc xclip tree fd \
   ripgrep postgresql alacritty flameshot docker nodejs npm dbeaver \
   base-devel git wireguard-tools net-tools zip unzip python-pipx \
   lazygit uv github-cli docker-compose cachyos-zsh-config \
   --noconfirm --needed


# pipx config
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
pipx completions


# install extra tools from AUR
pipx install ranger-fm


# install AUR
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
fi


# install extra tools from AUR
yay -S google-chrome postman-bin slack-desktop visual-studio-code-bin \
    another-redis-desktop-manager-bin


# set zsh as default
chsh -s /bin/zsh


# install fonts
mkdir -p ~/.local/share/fonts
find ~/workspace/fonts \( -name "*.ttf" -o -name "*.otf" -o -name "*.ttc" \) -type f -print0 | \
    xargs -0 -I {} cp "{}" ~/.local/share/fonts/

# alacritty config
if [ -f ~/.config/alacritty/alacritty.toml ]; then
    mv ~/.config/alacritty/alacritty.toml \
        ~/.config/alacritty/alacritty_default.toml
fi
cp -r ~/workspace/alacritty ~/.config
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone https://github.com/alacritty/alacritty-theme \
        ~/.config/alacritty/themes
fi
cp ~/workspace/.p10k.zsh ~/

# zsh config
cp ~/workspace/.zshrc ~/


# git config
read -s -p "Enter your Github access token: " git_token
echo
echo "https://kizeev:$git_token@github.com" > ~/.git-credentials

cat << EOF > ~/.gitconfig
[user]
   name = kizeev
   email = kizalvic@gmail.com
[credential]
   helper = store
EOF


# nvim config (lazy.nvim bootstraps itself on first launch, no separate clone needed)
rm -rf ~/.config/nvim
cp -r ~/workspace/nvim ~/.config


# tmux config
if [ ! -d ~/.tmux ]; then
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
fi
ln -sf ~/.tmux/.tmux.conf ~/
cp ~/workspace/tmux/.tmux.conf.local ~/


# config wireguard
sudo modprobe wireguard


# config docker
sudo systemctl enable docker
sudo systemctl start docker
sudo docker run -d --hostname rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.13-management
sudo docker run -p 6379:6379 --name redis -d redis


# config ranger-fm
mkdir -p ~/.config/ranger
cp ~/workspace/ranger/rifle.conf ~/.config/ranger/


# config postgres
sudo -u postgres initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'
sudo systemctl start postgresql
sudo systemctl enable postgresql
