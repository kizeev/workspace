#!/bin/bash
# Symlink the configs in this repo into $HOME, so `git pull` is all it takes
# to apply changes, and edits made in place (~/.config/nvim/...) land in the
# repo. Safe to re-run: correct links are left alone, anything else in the
# way is moved aside to <name>.bak (or <name>.bak.<timestamp>).
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$DOTFILES/$1" dst="$2"

    if [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
        return
    fi

    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup="$dst.bak"
        if [ -e "$backup" ] || [ -L "$backup" ]; then
            backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
        fi
        mv "$dst" "$backup"
        echo "backup: $dst -> $backup"
    fi
    ln -s "$src" "$dst"
    echo "link:   $dst -> $src"
}

# whole directory: nothing but our config lives there (lazy.nvim writes
# lazy-lock.json here too, which is meant to be committed)
link nvim                     ~/.config/nvim

link .zshrc                   ~/.zshrc
link .p10k.zsh                ~/.p10k.zsh
link tmux/.tmux.conf.local    ~/.tmux.conf.local
link bat/config               ~/.config/bat/config

# single files: these dirs also hold things that don't belong in the repo
# (alacritty: cloned themes/, vifm: vifminfo.json state)
link alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
link vifm/vifmrc              ~/.config/vifm/vifmrc
link vifm/colors/gruvbox.vifm ~/.config/vifm/colors/gruvbox.vifm
