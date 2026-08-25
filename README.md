Personal dotfiles + install script for setting up a fresh **CachyOS** machine
(Arch-based; the script uses `pacman`/`yay`, and `cachyos-zsh-config` is a
CachyOS-repo package — on plain Arch, drop that package and set up zsh/p10k
yourself).

## What's here

- `nvim/` — Neovim config (lazy.nvim, pyright + ruff via mason, telescope, etc.)
- `alacritty/` — terminal config, auto-attaches to a tmux session on launch
- `tmux/.tmux.conf.local` — personal tmux settings (mouse on, vi keys, etc.),
  layered on top of the [gpakosz/.tmux](https://github.com/gpakosz/.tmux) base
- `.zshrc`, `.p10k.zsh` — shell + prompt config
- `ranger/rifle.conf` — file opener rules for ranger
- `fonts/` — MesloLGS NF (required by the p10k prompt)
- `install_config.sh` — installs packages and copies all of the above into place

## Usage

```bash
git clone https://github.com/kizeev/workspace.git ~/workspace
chmod +x ~/workspace/install_config.sh
~/workspace/install_config.sh
```

**Before running:** this is meant for a genuinely fresh install. It runs
`sudo pacman -S`, installs `yay` and several AUR packages, overwrites
`~/.config/nvim`, `~/.zshrc`, `~/.tmux.conf.local`, `~/.gitconfig`, starts
Docker containers (redis, rabbitmq) and initializes a fresh PostgreSQL data
directory. Read through it before running on a machine that already has
config or data you care about — most of it is *not* meant to be re-run on an
already-configured system.
