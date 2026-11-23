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
- `vifm/` — file manager config (also opened from nvim with `<leader>e`)
- `bat/config` — bat theme
- `fonts/` — MesloLGS NF (required by the p10k prompt)
- `link.sh` — symlinks all of the above into place (see *Keeping machines in sync*)
- `install_config.sh` — installs packages, runs `link.sh`, sets up services

## Usage

```bash
git clone https://github.com/kizeev/workspace.git ~/workspace
chmod +x ~/workspace/install_config.sh
~/workspace/install_config.sh
```

**Before running:** this is meant for a genuinely fresh install. It runs
`sudo pacman -S`, installs `yay` and several AUR packages, overwrites
`~/.gitconfig`, replaces existing configs with symlinks (backed up as
`*.bak`), starts
Docker containers (redis, rabbitmq) and initializes a fresh PostgreSQL data
directory. Read through it before running on a machine that already has
config or data you care about — most of it is *not* meant to be re-run on an
already-configured system.


## Keeping machines in sync

Configs are **symlinked** into place by `link.sh`, not copied, so on any
machine:

- `git pull` in `~/workspace` applies changes immediately — nothing to copy;
- editing in place (`~/.config/nvim/...`, `~/.zshrc`) edits the repo, so the
  change shows up in `git status`, ready to commit and push.

`link.sh` is safe to re-run: links that are already correct are left alone,
anything else in the way is moved to `<name>.bak`. Run it after adding a new
config to the repo (and add a `link` line for it), or once on a machine that
still has copies from an older install.

Every new shell prints a one-line reminder above the prompt if the repo has
uncommitted changes or commits to push/pull. It fetches in the background at
most every 10 minutes, so a push from the other machine shows up in the
*next* shell, not the current one.

`nvim/lazy-lock.json` is committed on purpose: after updating plugins on one
machine, commit it, and `:Lazy restore` on the other one installs the same
versions.

**Secrets and machine-specific settings** (API keys, private aliases) go in
`~/.zshrc.local`, which `.zshrc` sources but which is not in the repo — this
repo is public.
