export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="iocaste"

plugins=(git svn z vi-mode tmux yarn npm)

# completion
setopt auto_menu
bindkey '^[[Z' reverse-menu-complete

# awesome keybindings
bindkey -M vicmd -s 'T' '^[ Isimonsays ^[A'
bindkey -M viins -s '^T' '^[ Isimonsays ^[A'

# This binds Ctrl-O to ranger-cd:
bindkey -M viins -s '^o' "ranger-cd"

# nix environment
if [[ "$IN_NIX_SHELL" ]]; then
  if [ ! -z "$shellHook" ]; then
    eval $shellHook
  fi
else
  source /home/arjen/.nix-profile/etc/profile.d/nix.sh
fi

source $ZSH/oh-my-zsh.sh
