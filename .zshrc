autoload colors && colors

# history settings
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt inc_append_history
setopt share_history

# disable annoying stuff
unsetopt beep nomatch notify
setopt autocd
setopt pushdsilent
setopt autopushd
setopt pushdminus
setopt interactivecomments

# leave expansion to _expand
bindkey '^I' complete-word

# vi mode shortcuts
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# vi mode with emacs behaviour
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M viins '^r' history-incremental-pattern-search-backward
bindkey '^[[Z' reverse-menu-complete

# vim-style behaviour
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^u' backward-kill-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^R' redo
bindkey -M vicmd '^R' redo

# awesome keybindings
bindkey -M vicmd -s 'T' '^[ Isimonsays ^[A'
bindkey -M viins -s '^T' '^[ Isimonsays ^[A'

# editing cmd in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# display the correct time and battery data
# every time the prompt is drawn
# and set the left prompt
function generic_precmd {
  local BAT

  # set the LPROMPT
  prompt="
  %{$fg[white]%}%~"
  if [[ "$EUID" = "0" ]] || [[ "$USER" = 'root' ]]
  then
    prompt="${prompt}%{$fg[red]%}"
  else
    prompt="${prompt}%{$fg[cyan]%}"
  fi

  prompt="${prompt} λ %{$fg[white]%}%{$reset_color%} "
}

# window title management if available
case $TERM in

  *rxvt*)

    # show process name
		preexec () { print -Pn "\e]0;$1\a" }

    # and reset afterwards
    precmd() {
      generic_precmd
      print -Pn "\e]0;urxvt \a"
    }
    ;;

  *)
    generic_precmd
    ;;
esac

# aliasses
alias ls='ls --color=auto'
alias gt='urxvt &'
alias django='python manage.py'
alias mk='mkdir -p'
alias r='ranger-cd'
alias simonsays='sudo'
alias isaid='sudo'
alias grep='grep --color=auto'
alias pc='percol --match-method=regex'
alias acks='ack --scala'
alias tm='tmux'
alias tma='tmux attach'
alias tmd='tmux detach'
alias npm-exec='PATH="`npm bin`:$PATH"'
alias c=xsel -ib
alias sack='ack --scala'
# smart standards
alias scp='rsync --partial --progress --rsh=ssh'
alias pcp='rsync -aP --info=progress2'
alias feh='feh -F'
alias ssh='TERM=xterm-color ssh'

# coding
alias html='w3m -T text/html'
alias -g json='-H "Accept: application/json; indent=2"'

function lc {
  # search up for a .gitignore file
  # and add them to the ls ignore patterns clause -I

  # actual command
  ls -gGhF --color=auto --group-directories-first $@
}

# handy global aliasses
alias -g '...'='../../'
alias -g '....'='../../../'

# git aliasses
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gc='git commit'
alias gap='git add -p'
function gpl {
  git pull origin `git branch | grep \* | sed 's/\* //'`
}
function gplr {
  git pull -r origin `git branch | grep \* | sed 's/\* //'`
}
function gps {
  git push origin `git branch | grep \* | sed 's/\* //'`
}

# open vim using a server name for future reference
function v {
  local server
  if [[ -z $2 ]]
  then
    server="VIMS"
  else
    server="$2"
  fi

  if vim --serverlist | grep -iq "$server"; then
    echo "$1 >>= $server"
    vim --servername "$server" --remote "$1"
  else
    vim --servername "$server" "$1"
  fi
}

# up, up, up the stairs...
function up {
  for a in {1..$1}
  do
    cd ../
  done
}
# and back, back, back through the alley
alias back=cd +

# fast find alias
function ff {
  find "`pwd`/" -regex ".*$1"
}

# fast find, select
function ffp {
  find `pwd`/ -regex ".*$1" | pc
}

# fast find, select and execute on xargs arguments
function ffx {
  find `pwd`/ -regex ".*$1" | pc | xargs $2
}
function ffxi {
  find `pwd`/ -iregex ".*$1" | pc | xargs $2
}

# Automatically change the directory in bash after closing ranger
function ranger-cd {
    tempfile='/tmp/chosendir'
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"

        # show the content of this directory
        lc
    fi
    rm -f -- "$tempfile"
}

# This binds Ctrl-O to ranger-cd:
bindkey -M viins -s '^o' "ranger-cd"

# completion plugins
fpath=(~/.zsh/completion $fpath)

# zshell globbing magic
setopt extendedglob

# do not select the first menu entry automatically
unsetopt menu_complete
autoload -U compinit
compinit

# use cache to make slow stuff like pip and pacman work nicely
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# list colors
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion Styles
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/history-substring-search/zsh-history-substring-search.zsh

# bind k and j for VI mode for history substring search
bindkey -M viins '^k' history-substring-search-up
bindkey -M viins '^j' history-substring-search-down

# ls coloring
eval $(dircolors ~/.dircolors)

# aoooooh
source ~/.zsh/plugins/z/z.sh

PATH="/home/arjen/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/arjen/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/arjen/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/arjen/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/arjen/perl5"; export PERL_MM_OPT;
