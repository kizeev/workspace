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
   vifm bat \
   --noconfirm --needed


# pipx config
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument
pipx completions




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


# install fonts: MesloLGS NF, required by the p10k prompt
# (Apache 2.0, https://github.com/romkatv/powerlevel10k-media)
mkdir -p ~/.local/share/fonts
for style in Regular Bold Italic "Bold Italic"; do
    curl -fsSL -o ~/.local/share/fonts/"MesloLGS NF $style.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${style// /%20}.ttf"
done

# configs: symlinked into place, so a later `git pull` in ~/workspace is all
# it takes to update them (nvim, zsh/p10k, tmux, alacritty, vifm, bat)
~/workspace/link.sh

# alacritty themes (imported by alacritty.toml)
mkdir -p ~/.config/alacritty/themes
if [ ! -d ~/.config/alacritty/themes/.git ]; then
    git clone https://github.com/alacritty/alacritty-theme \
        ~/.config/alacritty/themes
fi


# git config: identity is asked for rather than hardcoded; for a public repo
# use the GitHub noreply address (Settings -> Emails) to keep yours private
read -r -p "git user.name: " git_name
read -r -p "git user.email: " git_email
git config --global user.name "$git_name"
git config --global user.email "$git_email"

# GitHub auth via gh: the token goes to the system keyring (when available)
# instead of a plaintext ~/.git-credentials, and git uses gh as its helper
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git


# tmux base config (our .tmux.conf.local is linked by link.sh)
if [ ! -d ~/.tmux ]; then
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
fi
ln -sf ~/.tmux/.tmux.conf ~/


# config wireguard
sudo modprobe wireguard


# config docker
sudo systemctl enable docker
sudo systemctl start docker
sudo docker run -d --hostname rabbitmq --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.13-management
sudo docker run -p 6379:6379 --name redis -d redis


# config postgres
sudo -u postgres initdb --locale=C.UTF-8 --encoding=UTF8 -D '/var/lib/postgres/data'
sudo systemctl start postgresql
sudo systemctl enable postgresql
