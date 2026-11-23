source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# Created by `pipx` on 2026-03-10 15:08:15
export PATH="$PATH:$HOME/.local/bin"

# Autosuggestion color: fixed gruvbox gray instead of the default fg=8
# (bright black is darkened in alacritty.toml for Claude Code's panels)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#928374'

# vifm uses the exact 24-bit colors of its gruvbox colorscheme only on a
# *-direct terminfo entry: tmux-256color -> tmux-direct, alacritty ->
# alacritty-direct. Falls back to plain $TERM (256-color approximations)
# when truecolor isn't advertised, e.g. over ssh.
vifm() {
  local direct=${TERM%-256color}-direct
  if [[ $COLORTERM == (truecolor|24bit) ]] && infocmp $direct &>/dev/null; then
    TERM=$direct command vifm "$@"
  else
    command vifm "$@"
  fi
}

# Dotfiles sync reminder. ~/.zshrc is a symlink into the repo (see link.sh),
# so resolving it gives the repo path. Runs once, when the first prompt is
# already on screen (zle line-init): p10k's instant prompt captures anything
# printed earlier, precmd included, and warns about it. The fetch
# runs in the background (at most every 10 min); "behind" reflects the last
# fetch, so a fresh pull from another machine shows up in the next shell.
_dotfiles_dir=${${(%):-%x}:A:h}
if [[ -d $_dotfiles_dir/.git ]]; then
  _dotfiles_check() {
    add-zle-hook-widget -d line-init _dotfiles_check
    local dir=$_dotfiles_dir

    local -a fresh=($dir/.git/FETCH_HEAD(Nmm-10))  # fetched in the last 10 min?
    if (( ! $#fresh )); then
      (GIT_TERMINAL_PROMPT=0 git -C $dir fetch -q &>/dev/null &)
    fi

    local -a msg counts
    [[ -n $(git -C $dir status --porcelain 2>/dev/null) ]] && msg+=("uncommitted changes")
    counts=(${=$(git -C $dir rev-list --left-right --count HEAD...@{u} 2>/dev/null)})
    (( ${counts[1]:-0} )) && msg+=("$counts[1] to push")
    (( ${counts[2]:-0} )) && msg+=("$counts[2] to pull")

    if (( $#msg )); then
      zle -I  # print above the prompt, then let zle redraw it
      print -P "%F{yellow}dotfiles:%f ${(j:, :)msg}  %F{8}($dir)%f"
    fi
  }
  autoload -Uz add-zle-hook-widget
  add-zle-hook-widget line-init _dotfiles_check
fi

# Machine-specific settings and secrets (API keys, private aliases) — not in git
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
